Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90BE910944A
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Nov 2019 20:37:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725868AbfKYThu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Nov 2019 14:37:50 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43895 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbfKYThu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Nov 2019 14:37:50 -0500
Received: by mail-qt1-f196.google.com with SMTP id q8so15886480qtr.10
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2019 11:37:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z25xawtN9EUSB11ugnyS1CzBl5RXQyJZGVT3nErHeHI=;
        b=KJa+kB/yTTfHqmdiKjRACz4f2xR23AN+m007TZDFhYSHvcDiLd6V2V8Gq6pwkJ2vNu
         GEIlRJ59BshiM9Iyn6RsB69oTRIPUEIjrkX5FdK22zRGVOdq0tiB5HGvb4m2KS2EmaIM
         Kypr5eN/0KAonvZnHxldmiCtbeFXtW+iCFKPdTe5Z44MEv5AReN7iuHQBJF7xq8/eVPm
         K4bpwLSXTjbLqSDluyO+TKpRHW2RW7jlcts4HaUAFz+ERJsSR6546WsxoG7bBIwyLjs2
         Lg9NEuEe+JZnSP3/F5Gfm7nnczehz+b1MyESikE4DwiuIWityi+TYQ8ogFLAQU4jyE9u
         fIog==
X-Gm-Message-State: APjAAAWNQrgK+Ch1SkPMz4hR26hgJfvGfPkfmLHbYupGjV7Wp23vuE8B
        Vuib1ie9DtDI71LKcLUx5YY=
X-Google-Smtp-Source: APXvYqzMcUsAJ3qvsAHSvXqzB38MuDsjh/8ZX67lZniZAHtUxitDor7MC84kRXTK5rpUyz15h5F/Uw==
X-Received: by 2002:ac8:5053:: with SMTP id h19mr30933113qtm.38.1574710669100;
        Mon, 25 Nov 2019 11:37:49 -0800 (PST)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c091:500::2:6080])
        by smtp.gmail.com with ESMTPSA id b13sm4343128qtj.64.2019.11.25.11.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 11:37:48 -0800 (PST)
Date:   Mon, 25 Nov 2019 14:37:46 -0500
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.cz>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 04/22] btrfs: keep track of cleanliness of the bitmap
Message-ID: <20191125193746.GB30548@dennisz-mbp.dhcp.thefacebook.com>
References: <06410c758182c36e3af04249721ded50d8f2c62f.1574282259.git.dennis@kernel.org>
 <201911230623.j5g9qeNZ%lkp@intel.com>
 <20191125135910.GD2734@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191125135910.GD2734@twin.jikos.cz>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 25, 2019 at 02:59:10PM +0100, David Sterba wrote:
> On Sat, Nov 23, 2019 at 08:17:13AM +0800, kbuild test robot wrote:
> > Hi Dennis,
> > 
> > I love your patch! Yet something to improve:
> > 
> > [auto build test ERROR on kdave/for-next]
> > [cannot apply to v5.4-rc8 next-20191122]
> > [if your patch is applied to the wrong git tree, please drop us a note to help
> > improve the system. BTW, we also suggest to use '--base' option to specify the
> > base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> > 
> > url:    https://github.com/0day-ci/linux/commits/Dennis-Zhou/btrfs-async-discard-support/20191121-230429
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
> > config: arm-allmodconfig (attached as .config)
> > compiler: arm-linux-gnueabi-gcc (GCC) 7.4.0
> > reproduce:
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # save the attached .config to linux build tree
> >         GCC_VERSION=7.4.0 make.cross ARCH=arm 
> > 
> > If you fix the issue, kindly add following tag
> > Reported-by: kbuild test robot <lkp@intel.com>
> > 
> > All errors (new ones prefixed by >>):
> > 
> > >> ERROR: "__aeabi_uldivmod" [fs/btrfs/btrfs.ko] undefined!
> 
> That does not point to a particular line, but there's
> 
> +	/* If we ended in the middle of a bitmap, reset the trimming flag. */
> +	if (end % (BITS_PER_BITMAP * ctl->unit))
> +		reset_trimming_bitmap(ctl, offset_to_bitmap(ctl, end));
> 
> added and its "u64 % (unsigned long * int)" that could be the cause.

Yeah that seems to be it. I wasn't careful enough with my u64s. I'm
going to send out v4 which should fix this issue and the uninitialized
variable use in patch 4.

Thanks,
Dennis
