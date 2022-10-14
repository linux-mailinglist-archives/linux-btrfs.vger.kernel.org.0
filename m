Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5CE95FEE15
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Oct 2022 14:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiJNMn2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Oct 2022 08:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiJNMn1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Oct 2022 08:43:27 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF98A1C7112
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Oct 2022 05:43:26 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id h24so3201472qta.7
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Oct 2022 05:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fezNainiYgVOelk+pTs2yNAqiPadUJTgf0XECk65J7k=;
        b=EYUHWjDCl9p4KhNocCe/eLP1CrumiBk07rysp9vJF4Xt6wBnrzoZyyZ/dm5/oph+8W
         3YawuAMHcdi+l91ZZ8l1O/TwzzAerGNoINvSDTO6DIc1eEaQn7Du5/jGQagqD1KDxRmk
         2zDdJn8iPwFl4w8za/X+9r5zV8dc55ZvPZioEhf36lrGwRKwcr5GWY4To+OFiQqM817A
         bEN2zgEKfJsTlhAOIb4Qlt34XIZOZASLKIiqPcS0SQbk2csi19GXeRpp3PMRHETQA5SG
         l0RymkEpR4XhQHq6qQJLD4McT7PL+vNpO2IGh5ZYb/QAUT6IapqopwlmFUP0k6+eT627
         H7pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fezNainiYgVOelk+pTs2yNAqiPadUJTgf0XECk65J7k=;
        b=LQZFF0thvnz5VqkknI33P7mSTOTXy846zSVdSOkXPxUwaaSUMJRkQc51w/mKFZer3v
         JBk5/5d9rWX1srNS4wqWeiI7imI0NGqCTL8YtRIFOnS6cAHJ9FHN25K8l71lSWap0QCG
         NuG3UvMEIIwtI2jf1ymmxL+XLJwWH299snOlKnS9iVGeOcWlTAfVya3eJmIo9VBdTNfh
         MqRu4fmreuAajgiK1uroAunCY5pBlFXTNhf+ShvmbLJGlPVrrkBxjXO8cchkkw6P6v2W
         v3o+KeCPgrOClGuqn5o721p3QA5QNLJbRk2RyQi20BrUz5tBV6OItbgaY4gJHVrUGmtA
         wXsQ==
X-Gm-Message-State: ACrzQf2sgl6p1tH1nO4w5GprE01Nma3Wey/gbTudSa8unqmrf5zXq+4S
        2UQAU0gaxMh8EBQt8motqkHKR/4snGpH6A==
X-Google-Smtp-Source: AMsMyM5yhqtqRArD9OaY2L+8H1hlMCtreXbT9YKN/CeueQCk5MKWzmSaY0F2r0nrLudWwkZyQpTS0Q==
X-Received: by 2002:a05:622a:356:b0:35d:55ae:43ab with SMTP id r22-20020a05622a035600b0035d55ae43abmr3939464qtw.430.1665751405955;
        Fri, 14 Oct 2022 05:43:25 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id w7-20020ac86b07000000b00342f8d4d0basm1968013qts.43.2022.10.14.05.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 05:43:25 -0700 (PDT)
Date:   Fri, 14 Oct 2022 08:43:24 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 15/15] btrfs: introduce a debug mount option to do
 error injection for each stage of open_ctree()
Message-ID: <Y0lZbFnapZ6Z3Xcv@localhost.localdomain>
References: <cover.1665565866.git.wqu@suse.com>
 <cb7312a3d6c88100df88dc61c911e6d5e8455070.1665565866.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb7312a3d6c88100df88dc61c911e6d5e8455070.1665565866.git.wqu@suse.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 12, 2022 at 05:13:11PM +0800, Qu Wenruo wrote:
> With the new open_ctree_seq[] array, we can afford a debug mount option
> to do all the error inject at different stages to have a much better
> coverage for the error path.
> 
> The new "fail_mount=%u" mount option will be hidden behind
> CONFIG_BTRFS_DEBUG option, and when enabled it will cause mount failure
> just after the init function of specified stage.
> 
> This can be verified by the following script:
> 
>  mkfs.btrfs -f $dev
>  for (( i=0;; i++ )) do
> 	mount -o fail_mount=$i $dev $mnt
> 	ret=$?
> 	if [ $ret -eq 0 ]; then
> 		umount $mnt
> 		exit
> 	fi
>  done
>  umount $mnt
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Death to all mount options, especially for this.  I'd rather see something like
this inserted in the main loop

bool btrfs_mail_fail_init(struct btrfs_fs_info *fs_info, int seq)
{
	return false;
}
ALLOW_ERROR_INJECTION(btrfs_may_fail_init);

and then we can error inject that way.  Alternatively you could just use
ALLOW_ERROR_INJECTION for every one of the init/exit functions and acheive the
same thing.  Thanks,

Josef
