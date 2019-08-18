Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7B1191786
	for <lists+linux-btrfs@lfdr.de>; Sun, 18 Aug 2019 17:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbfHRPom (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 18 Aug 2019 11:44:42 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42763 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbfHRPol (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 18 Aug 2019 11:44:41 -0400
Received: by mail-pg1-f195.google.com with SMTP id p3so5447547pgb.9;
        Sun, 18 Aug 2019 08:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RgCcS7v5Pg+5UB5zUcqsSyO+GrveaG+JVKtWvrOLfo8=;
        b=A8Dxip88s9rFKO9QVnljhrfhnwhSXtsuVjzmi/EGdg3NVf8C91lcq25fUbjfzhW6am
         a8MPKb0fs9cyHSMttM/0vYHsokRb4Yov7WbSKQUKjg/6eV8F7tY5boBb5J7J/S9oBIDe
         HNGtWiGOoKwHgXG3a6Ke2TaPoI6EiO9h+nRCjxq/krDW3WcN7oLB/tquO1LdSLZ8Ps79
         dCUCDviEi0IR47e6Fr3fTehZ6I2YsSWb59/nvWzmC3O2s+3deq2tmU+PeOIgGZI5r2X5
         A8lQYnaO2S5Axueje2DtwoausnezYvcAlbtG/swzEBnQTZaYfiGmBF2OyKAAbQHMJfjD
         sDPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RgCcS7v5Pg+5UB5zUcqsSyO+GrveaG+JVKtWvrOLfo8=;
        b=okwNuLGbZFrpojXUE6dXbkoWjbQY1Md7m9fnU5HrzIZhJm4EDfok9zgrReFTGFLVvD
         CYuLqOerVGnfe9nAhHcxM/JiiqPuX5UfVXoKconHr4ErnT4P22L9QnPyh1/S0jz3qEsV
         HqDcguXgkhnNEWWkXqvyEkO7lqEtKEWU06plaPBqC3I4DxoUv62Sp7ZeKn9uoO6BSfh4
         vU0IUcC698y8zFC+5LWv273b5w8TfPLoJqL4cqB1XWMRVDOc6BYalIDvhqP+xFdaDW+8
         /gYaJQ3m4n9y1OQ39U1/HxqVHgrU/RoXrnJX4qaJfFSrQSCKq7aPq6FRNnz8lkWRmYbp
         sgKQ==
X-Gm-Message-State: APjAAAVzsHaxILzBbVLi46UwCThIDbEc1AV+rh7Q4gCEipI+x4HR2DcW
        gmQHEFdfTDhpdfCW5jnvAx8=
X-Google-Smtp-Source: APXvYqyPHPtbhqvCKfnponTRzj/Mad0mXJ3tBBo68QbzMzYXyuWdPEDkTYP5gkqzteULebl83kmh9w==
X-Received: by 2002:a17:90a:9f09:: with SMTP id n9mr16710542pjp.72.1566143080987;
        Sun, 18 Aug 2019 08:44:40 -0700 (PDT)
Received: from localhost ([178.128.102.47])
        by smtp.gmail.com with ESMTPSA id p5sm13744157pfg.184.2019.08.18.08.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2019 08:44:40 -0700 (PDT)
Date:   Sun, 18 Aug 2019 23:44:28 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com, "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH] fstests: generic/500 doesn't work for btrfs
Message-ID: <20190818154016.GB2845@desktop>
References: <20190815182659.27875-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190815182659.27875-1-josef@toxicpanda.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 15, 2019 at 02:26:59PM -0400, Josef Bacik wrote:
> Btrfs does COW, so when we unlink the file we need to update metadata
> and write it to a new location, which we can't do because the thinp is
> full.  This results in an EIO during a metadata write, which makes us
> flip read only, thus making it impossible to fstrim the fs.  Just make
> it so we skip this test for btrfs.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  tests/generic/500 | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/tests/generic/500 b/tests/generic/500
> index 201d8b9f..5cd7126f 100755
> --- a/tests/generic/500
> +++ b/tests/generic/500
> @@ -49,6 +49,12 @@ _supported_os Linux
>  _require_scratch_nocheck
>  _require_dm_target thin-pool
>  
> +# The unlink below will result in new metadata blocks for btrfs because of CoW,
> +# and since we've filled the thinp device it'll return EIO, which will make
> +# btrfs flip read only, making it fail this test when it just won't work right
> +# for us in the first place.
> +test $FSTYP == "btrfs"  && _notrun "btrfs doesn't work that way lol"

I'm wondering if we could introduce a proper _require rule to cover this
case? e.g. require the fs doesn't allocate new blocks on unlink? or
something like that. But I'm not sure what's the proper fs feature to
require here, any suggestions?

Thanks,
Eryu

> +
>  # Require underlying device support discard
>  _scratch_mkfs >>$seqres.full 2>&1
>  _scratch_mount
> -- 
> 2.21.0
> 
