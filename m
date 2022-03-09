Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD1F34D316D
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Mar 2022 16:06:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233724AbiCIPG5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Mar 2022 10:06:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbiCIPG4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Mar 2022 10:06:56 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F98717E35D
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Mar 2022 07:05:57 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id t19so2178523plr.5
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Mar 2022 07:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nQOyOEoo04ZvQd5eIuQlZjtzKhcikQWTDsCE0EDfGdI=;
        b=AonCkaLubShLjFXukB9vma2P+NCZt1k2k4HooCVQEUg6eW9Y12VLw8JpRQfUgBfwbw
         c05kDj3S3ENcDAnHylfW3LSM60/Qbcv0QmyZCe70OH2CIFsaEv7P+zExF/NbWIZQYMjN
         p5BXhsAdSQozHE2WbW8ADRCtE6impdF+b1Fp0HnYvgDwhFuvzSvoq1Z+Z6yTnnJqVp9p
         PKC/X8WaeyA9pKoTSGut0xmxgAZYFPndArMDw5YghiO8w28IiUAaGSgvMjOyOyv1/176
         esyk6Q2rozgBGQa4GP4z9OtYC4ZE9q4JlbAcm1JMbf6LbhL16h8osjECAsjmbUbU/vWU
         CRwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nQOyOEoo04ZvQd5eIuQlZjtzKhcikQWTDsCE0EDfGdI=;
        b=TufUuVQhkYa4/gCKPb2RYHxgjRnuohBaz0FOedmtYgzL8pRd5jRzctRJYAKxLz8Ghn
         Nt6SPxnD/Bazw6OSAFz3RjgtpRZvMYGFpxIk120vbOLxm6VAhMqWdmm+ZFZ/lM8/ZCBN
         ZGNbK7xhy8lyiOXweU1VvJmBLTdXRBO+oZQ/U41/JJU8wdHs9wB6SbS2AZPhbevquVQ1
         kRFIbOYFxoYxPhAqaAT6/5eXUmUVaCeZtJv66miMEWH4Upeahbl0TdUQUzqs6g/cUKyV
         TEQngb5A14Q7L9jFp7BmUcsYyqzvJWKkqQaICjYhpPfEaYTUChv+28ANZLuJkdTk/DXN
         LSmA==
X-Gm-Message-State: AOAM532LQcNtWZkUNNzu3WXlD5QJfBjHQbY2UGu3Ce0L6gY8LaoGgCvp
        pZsc0InGcj46XDpbTpvOlIs=
X-Google-Smtp-Source: ABdhPJyFrTTYw+1KjegY7gt3U1U21j8WXK0R6nLFu/63FqIOuKJ4kSsFLLjQr2G1Qf6SMGi26IbIKA==
X-Received: by 2002:a17:90a:7082:b0:1bd:3838:3622 with SMTP id g2-20020a17090a708200b001bd38383622mr10757715pjk.101.1646838356911;
        Wed, 09 Mar 2022 07:05:56 -0800 (PST)
Received: from realwakka ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id m12-20020a17090a414c00b001bf6d88870csm2960295pjg.55.2022.03.09.07.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 07:05:56 -0800 (PST)
Date:   Wed, 9 Mar 2022 15:05:52 +0000
From:   Sidong Yang <realwakka@gmail.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs-progs: subvolme: remove unused options for
 create and snapshot
Message-ID: <20220309150552.GB46482@realwakka>
References: <20220309081418.46215-1-realwakka@gmail.com>
 <4a594830-8a8c-dbe3-15d0-1a62a1adfaa2@gmx.com>
 <20220309131745.GA46482@realwakka>
 <41958102-fdb4-7558-b7a4-c38560679809@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41958102-fdb4-7558-b7a4-c38560679809@gmx.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 09, 2022 at 09:25:45PM +0800, Qu Wenruo wrote:
> 
> 
> On 2022/3/9 21:17, Sidong Yang wrote:
> > On Wed, Mar 09, 2022 at 04:52:15PM +0800, Qu Wenruo wrote:
> > > 
> > > 
> > > On 2022/3/9 16:14, Sidong Yang wrote:
> > > > There are options '-c' in create subvolume and '-c' and '-x' in
> > > > snapshot. And the codes about them is there, but not in the manual or
> > > > help. This codes should be removed to avoid confusion.
> > > 
> > > I'd like more explanation on why we don't use it.
> > > 
> > > In fact the truth is, those -c/-x allows us to directly copy qgroup
> > > numbers from other subvolumes when creating subvolume.
> > > 
> > > This is definitely going to screw up qgroup numbers.
> > 
> > Actually, I don't understand that you said this option screw up qgroup
> > numbers. Could you explain more?
> > I checked that -c/-x options are not working. The commands are like
> > below.
> > 
> > # btrfs qgroup create 1/0 /mnt
> > # btrfs qgroup create 1/1 /mnt
> > # btrfs subvol create -c 1/0:1/1 /mnt/a
> > 
> > But it's not working. It seems that it ignores btrfs_qgroup_inherit
> > argument. New subvolume doesn't inherit anything.
> 
> Those -c/-x is for qgroup refer/exclusive copy.
> 
> Check btrfs_qgroup_inherit(), there are two for loops, one for
> num_ref_copies, the other for num_excl_copies.
> 
> In those loops, we just copy the number directly.
> (And of course, mark qgroup inconsistent).

I see that it just copies rfer/excl directly. Thanks!
I'll add more explaination for next version.

Thanks,
Sidong
> 
> Thanks,
> Qu
> 
> > 
> > > 
> > > Nowadays btrfs qgroup will automatically inherit the qgroup numbers when
> > > -i option is used.
> > 
> > Totally agree. -i option is enough to use.
> > 
> > Thanks,
> > Sidong
> > > 
> > > So the old -c/-x is no longer needed, and any inexperienced usage of
> > > them will lead to inconsistent qgroup numbers anyway.
> > > 
> > > Thanks,
> > > Qu
> > > 
> > > > 
> > > > Signed-off-by: Sidong Yang <realwakka@gmail.com>
> > > > ---
> > > >    cmds/subvolume.c | 25 ++-----------------------
> > > >    1 file changed, 2 insertions(+), 23 deletions(-)
> > > > 
> > > > diff --git a/cmds/subvolume.c b/cmds/subvolume.c
> > > > index fbf56566..408aebee 100644
> > > > --- a/cmds/subvolume.c
> > > > +++ b/cmds/subvolume.c
> > > > @@ -108,18 +108,11 @@ static int cmd_subvol_create(const struct cmd_struct *cmd,
> > > > 
> > > >    	optind = 0;
> > > >    	while (1) {
> > > > -		int c = getopt(argc, argv, "c:i:");
> > > > +		int c = getopt(argc, argv, "i:");
> > > >    		if (c < 0)
> > > >    			break;
> > > > 
> > > >    		switch (c) {
> > > > -		case 'c':
> > > > -			res = btrfs_qgroup_inherit_add_copy(&inherit, optarg, 0);
> > > > -			if (res) {
> > > > -				retval = res;
> > > > -				goto out;
> > > > -			}
> > > > -			break;
> > > >    		case 'i':
> > > >    			res = btrfs_qgroup_inherit_add_group(&inherit, optarg);
> > > >    			if (res) {
> > > > @@ -541,18 +534,11 @@ static int cmd_subvol_snapshot(const struct cmd_struct *cmd,
> > > >    	memset(&args, 0, sizeof(args));
> > > >    	optind = 0;
> > > >    	while (1) {
> > > > -		int c = getopt(argc, argv, "c:i:r");
> > > > +		int c = getopt(argc, argv, "i:r");
> > > >    		if (c < 0)
> > > >    			break;
> > > > 
> > > >    		switch (c) {
> > > > -		case 'c':
> > > > -			res = btrfs_qgroup_inherit_add_copy(&inherit, optarg, 0);
> > > > -			if (res) {
> > > > -				retval = res;
> > > > -				goto out;
> > > > -			}
> > > > -			break;
> > > >    		case 'i':
> > > >    			res = btrfs_qgroup_inherit_add_group(&inherit, optarg);
> > > >    			if (res) {
> > > > @@ -563,13 +549,6 @@ static int cmd_subvol_snapshot(const struct cmd_struct *cmd,
> > > >    		case 'r':
> > > >    			readonly = 1;
> > > >    			break;
> > > > -		case 'x':
> > > > -			res = btrfs_qgroup_inherit_add_copy(&inherit, optarg, 1);
> > > > -			if (res) {
> > > > -				retval = res;
> > > > -				goto out;
> > > > -			}
> > > > -			break;
> > > >    		default:
> > > >    			usage_unknown_option(cmd, argv);
> > > >    		}
