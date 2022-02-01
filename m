Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56EB04A55CD
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Feb 2022 05:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbiBAEGH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Jan 2022 23:06:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbiBAEGH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Jan 2022 23:06:07 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B82C061714
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Jan 2022 20:06:06 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id s61-20020a17090a69c300b001b4d0427ea2so1339626pjj.4
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Jan 2022 20:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wJU/EdXVCEljX1AGBsWrbo9PtxgEpwfSAORltS1xb3U=;
        b=c3VXTiLLOEou7zuDDgcNMeGg2Bqj4cTIh1JK7UsX3jEJka+I05r1dwfU9Mp7EpGSC6
         C44an5zYCwf/qBOudFVJl0RR7dbVMvvzVHCLfOYBj+auVtU6Vf0ssoytGg6WcQWHaqrG
         T1f+XfmEkXW2L6+qd23qvB40+2O0l50UQf75dc/goYqDDkLfm3C8m7j5wtw7OGqpZPa+
         uy1MsluQt5u1gceo/Tom4C9sI/YkAPnXXQy6hb+qiGoa3pziTCmS8ruF63U4JE4dP4W2
         esKId1sNKvrhSSvSOA1rCmP0ncp7WB2C+jnhxveMoEnfMUehTJWMUrvTfUtenpwogjPh
         4SVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wJU/EdXVCEljX1AGBsWrbo9PtxgEpwfSAORltS1xb3U=;
        b=GgLKbfcgjJpSHnOLXaw3AmoVxrtT5ASV5faR4JH3IkBTIAQgdsux0QpCQLg6xHeLpX
         HCXn0YHFMrDTkcCWqDgOnW92eCBPcpiS9rESomLdTNkl3RlRy7+I8QL/udFruyeOp8FX
         sjlelyo1bVXU9XqVP75gus7V1Vi5kZ1ubAqCWX5hrYRhX9xvKEfXIC4P7JoJXAWz6A6c
         yf8Lxr5Bl6+jU2nVyTu3TPRCvSiwuFean+onlMnhYGmdwcy3Lh2I9+8jnWBymJGhbjr/
         RNA09SjSGY5QI3eEMDjaY0hyhNHVYV3KnAm/5xoGmNk4Vt5j9mrCocAuDMSKBxDYlFRW
         uPgA==
X-Gm-Message-State: AOAM530yFS+UbT05ARWUpuUn//g9IqDFUyayLYMmd0/fSF7RnIz6389K
        z7pCOPPMj9bGJHxsrU/ca9/icIPe1JhP1A==
X-Google-Smtp-Source: ABdhPJzZ7rzhdMhDrtmdSWqh/K4h7S3wT01oGGMEUZMJbV1nVG7i26eAYcmEa6t1xT25SmqldbUECg==
X-Received: by 2002:a17:90b:2516:: with SMTP id ns22mr172463pjb.242.1643688366269;
        Mon, 31 Jan 2022 20:06:06 -0800 (PST)
Received: from realwakka ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id d10sm17160484pfl.16.2022.01.31.20.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 20:06:05 -0800 (PST)
Date:   Tue, 1 Feb 2022 04:05:58 +0000
From:   Sidong Yang <realwakka@gmail.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: A question for kernel code in btrfs_run_qgroups()
Message-ID: <20220201040558.GA25465@realwakka>
References: <20220131154040.GA25010@realwakka>
 <f5d1c08b-b843-6d5d-341d-c19890872e04@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5d1c08b-b843-6d5d-341d-c19890872e04@gmx.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 01, 2022 at 08:21:22AM +0800, Qu Wenruo wrote:

Hi Qu,

Thanks for answering

> 
> 
> On 2022/1/31 23:40, Sidong Yang wrote:
> > Hi, I'm reading btrfs code for contributing.
> > I have a question about code in btrfs_run_qgroups().
> > 
> > It seems that it updates dirty qgroups modified in transaction.
> 
> Yep.
> 
> > And it iterates dirty qgroups with locking and unlocking qgroup_lock for
> > protecting dirty_qgroups list. According to code, It locks before enter
> > the loop and pick a entry and unlock. At the end of loop, It locks again
> > for next loop. And after loop, it set some flags and unlock.
> > 
> > I wonder that it should be locked with setting STATUS_FLAG_ON? if not,
> > is there unnecessary locking in last loop?
> 
> From a quick look, it indeed looks like we don't need to hole
> qgroup_lock to modify qgroup_flags.
> In fact, just lines below, we update qgroup_flags without any lock for
> INCONSISTENT bit.

Apparently it is, but I don't know surely that it really don't need to
hold lock while modifying qgroup_flags.
It has FLAG_ON that it indicates that quota turned on. I think it should
be modified carefully. Or it can be protected by other locks like
qgroup_lock or ioctl_lock?

> 
> 
> Unfortunately we indeed have inconsistent locking for qgroups_flags.

I agree. there is a lot of codes that modify qgroup_flags without lock
or with lock.

> 
> So it's completely possible that we may not need to do modify the
> qgroup_flags under qgroup_lock.
> 
> In fact there are tons of call sites that we don't hold locks for
> qgroups_flags update.
> 
> So if you're interested in contributing to btrfs, starting from sorting
> the qgroup_lock usage would be a excellent start.

Yeah, I really interested in this. but I don't know good way to handle
this problem. is it really good way to remove the code holding lock
while modifying flags?

Thanks,
Sidong

> 
> Thanks,
> Qu
