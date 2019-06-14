Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF11462E4
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Jun 2019 17:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbfFNPeT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Jun 2019 11:34:19 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46289 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbfFNPeT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Jun 2019 11:34:19 -0400
Received: by mail-pf1-f196.google.com with SMTP id 81so1671905pfy.13;
        Fri, 14 Jun 2019 08:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=VcqZSTfOOTG7AMnLIvNFLJiYzNUQ9IggEtYnxRQLLCw=;
        b=cX1rNV+2kByelj3aRHal2nkMvSEybh2ne3gjRKQLyq/psOp4P4W36nJUxqHca+Bcve
         fa0/6Y6jBxg1+c2KzvqvaUmqscKgM0K6hZVYuIEfPhKes95rL4OM7rqA/iMZw3a2+BIc
         j5pLf6/GVjAccFAWx9DrACLVYTFy/GnZAjj+/N/W834r2sAefVBySJt65wBc4yF8ImNc
         ut5GQnHNKOxecBWoTEy4T1OMtJb/P6W4WIR8J0fVTFau7rD7GCJPUFz22twflA/Gk+1O
         Weu0lVEqZs+tuJ2/U4Wd6R6VzdmfNLOdxQ+ICzXgGdNgbNKeA7jsuBjygxHdU274ySeu
         UjYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=VcqZSTfOOTG7AMnLIvNFLJiYzNUQ9IggEtYnxRQLLCw=;
        b=X/g4ydHGBHJjb0V4ZQ4KQTwhaF2Gt33ewHXStA9RGNPyBi+8GOHSunatjumTbAFf/b
         m9eabllpafpaWUD0RgY7zFhgNKOeij9GpwWqoxSC63ZP4MUOBHRHkXeRcwE6keX7ctrT
         /jo8VGs9oyuQ0lQByWAy7kcXfOCu9uupzZ6AShPAqR6/PNp+i1vH71ei/4HjTEqRF/Iq
         2Y3GNId2PVJO2wpygxTTcy5bf9MaFSNsM7P7A7Uh36nKv4dCha7y83s/Hvq3iQwdPrPC
         kfWi01iKNTBy8HkpXxrd6oOEWW0fXe6+sK2OyZlHR/lhXK0rUqjsmyyhHpICos614IL6
         96CA==
X-Gm-Message-State: APjAAAWK3yKB6txhi0Dyw7inuj3eY61tjGbnyXxRMCf5NLaRk2oEIbP2
        mowBRVdfzPzQ+W88HPofSws=
X-Google-Smtp-Source: APXvYqwb9cE5Z3QlVQVAVj601wOklPNy1XyRHzrFQZIGofhht1ieXqlLTiZ979Kxs19wgO9U4MB4AA==
X-Received: by 2002:a63:4d17:: with SMTP id a23mr5115988pgb.22.1560526458229;
        Fri, 14 Jun 2019 08:34:18 -0700 (PDT)
Received: from localhost ([2620:10d:c090:180::1:b330])
        by smtp.gmail.com with ESMTPSA id y19sm3039003pfe.150.2019.06.14.08.34.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 08:34:17 -0700 (PDT)
Date:   Fri, 14 Jun 2019 08:34:13 -0700
From:   Tejun Heo <tj@kernel.org>
To:     dsterba@suse.cz, dsterba@suse.com, clm@fb.com,
        josef@toxicpanda.com, axboe@kernel.dk, jack@suse.cz,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 7/8] Btrfs: use REQ_CGROUP_PUNT for worker thread
 submitted bios
Message-ID: <20190614153413.GD538958@devbig004.ftw2.facebook.com>
References: <20190614003350.1178444-1-tj@kernel.org>
 <20190614003350.1178444-8-tj@kernel.org>
 <20190614151524.GZ3563@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190614151524.GZ3563@twin.jikos.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello, David.

On Fri, Jun 14, 2019 at 05:15:24PM +0200, David Sterba wrote:
> fs/btrfs/inode.c: In function ‘cow_file_range_async’:
> fs/btrfs/inode.c:1278:4: error: implicit declaration of function ‘css_get’; did you mean ‘css_put’? [-Werror=implicit-function-declaration]
>  1278 |    css_get(blkcg_css);
>       |    ^~~~~~~
>       |    css_put
> 
> I don't have CONFIG_CGROUPS enabled in the testing kernel so this probably
> needs a wrapper so the ifdef is not in the middle of the function.

Yeah, got a bunch of kbuild warnings last night.  I'll fix them up and
send v2 patchset.

Thanks.

-- 
tejun
