Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C81B437183
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Oct 2021 08:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbhJVGFA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Oct 2021 02:05:00 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:43434 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbhJVGE6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Oct 2021 02:04:58 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 932CF1FD58;
        Fri, 22 Oct 2021 06:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634882560; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KTiMv779FF5LfGLorJTVWL/B3izHxoYba15Fcl5ghN4=;
        b=gdEJ1PFRwc/WLWcOcUrIx9GJulN24SvKfMQhaayIjJxikcQtTh/mDVjePpL/3yg9gaYNN7
        vRBU+AVxORDQbO+yf1w4hKyzBLqLxU4z97XIJQ+baQozWhsptplm5SGkaw6NvemVFw4tkh
        MYpJasAE8zaSLS8TRtEvr6pFfmDoAMo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 43B8B13A17;
        Fri, 22 Oct 2021 06:02:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iHdeDQBUcmFYfgAAMHmgww
        (envelope-from <nborisov@suse.com>); Fri, 22 Oct 2021 06:02:40 +0000
Subject: Re: 5.14.9 aarch64 OOPS Workqueue: btrfs-delalloc btrfs_work_helper
To:     Chris Murphy <lists@colorremedies.com>, Su Yue <l@damenly.su>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAJCQCtTqR8TJGZKKfwWB4sbu2-A+ZMPUBSQWzb0mYnXruuykAw@mail.gmail.com>
 <e18c983f-b197-4fc5-8030-cc4273eda881@suse.com>
 <CAJCQCtSAWqeX_3kapDLr8AzNiGxyrNE7cO_tr3dM-syOKDsDgw@mail.gmail.com>
 <b1fccb42-da8a-c676-5f0b-1d80319e38ca@suse.com>
 <CAJCQCtSRxFuU4bTTa5_q6fAPuwf3pwrnUXM1CKgc+r69WSE9tQ@mail.gmail.com>
 <eae44940-48cb-5199-c46f-7db4ec953edf@suse.com>
 <CAJCQCtR+YQ2Xypz3KyHgD=TvQ8KcUsCf08YnhvLrVtgb-h9aMw@mail.gmail.com>
 <CAJCQCtQHugvMaeRc1A0EJnG4LDaLM5V=JzTO5FSU9eKQA8wxfA@mail.gmail.com>
 <CAJCQCtT12qUxYqJAf8q3t9cvbovoJdSG9kaBpvULQnwLw=rnMg@mail.gmail.com>
 <bl3mimya.fsf@damenly.su> <e75cf666-0b3a-9819-c6ac-a34835734bfb@gmx.com>
 <CAJCQCtT1+ocw-kQAKkX3wKjd4A1S1JV=wJre+UK5KY-weS33rQ@mail.gmail.com>
 <CAJCQCtTqqHFVH5YMOnRSesNs9spMb4QEPDa5wEH=gMDJ_u+yUA@mail.gmail.com>
 <7de9iylb.fsf@damenly.su>
 <CAJCQCtSUDSvMvbk1RmfTzBQ=UiZHrDeG6PE+LQK5pi_ZMCSp6A@mail.gmail.com>
 <35owijrm.fsf@damenly.su>
 <CAJCQCtS-QhnZm2X_k77BZPDP_gybn-Ao_qPOJhXLabgPHUvKng@mail.gmail.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <9b2cd532-3abc-13db-0c51-c604b8c1d227@suse.com>
Date:   Fri, 22 Oct 2021 09:02:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtS-QhnZm2X_k77BZPDP_gybn-Ao_qPOJhXLabgPHUvKng@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 22.10.21 г. 5:36, Chris Murphy wrote:
> OK I have a vmcore file:
> https://dustymabe.fedorapeople.org/bz2011928-vmcore/
> 
> lib/modules/5.14.10-300.fc35.aarch64/vmlinuz
> https://drive.google.com/file/d/1xXM8XGRi_Wzyupbm4MSNteF0rwUzO4GE/view?usp=sharing

In order to open the dump we require the vmlinux as well as the debug
vmlinuz and also btrfs.ko.debug file as well.

> 
> 
> --
> Chris Murphy
> 
