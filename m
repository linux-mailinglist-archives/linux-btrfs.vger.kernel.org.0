Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F02D4D3C01
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Mar 2022 22:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232838AbiCIVXr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Mar 2022 16:23:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbiCIVXq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Mar 2022 16:23:46 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9013E6420
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Mar 2022 13:22:47 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id j5so3019981qvs.13
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Mar 2022 13:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5BybgI3ufsI0ReTExyQ1WaZdrh94B7x8b54cBXkE0lk=;
        b=5VDZjORF9lxcAbrPHMiuVfwnXEQE9nV78nrJDhhnhgX41Uryg4odTdAss0gF/vSkKk
         LSLmd6X4dEQY0z074B6Dg3itYbQlt1YXvOFZNc+0ql4mgMHofkw3buJWdDn/mbmrjUxP
         5eK44v/oV/0aoceR5OkW9attQWzezj0duZDArNIwD58+G09m1Oya8jehoTkAV3G7wgkp
         GAwiEJVVOvr+zOIFT/MmyJneibd/yxf8bzaT8DEE92mPGEniVJna/P/+WFTMfY76CLae
         OwhDCm2udhdo7xYPCP2D2kTno+/G5atAjSOumOz6/y598jH5rtXygsExhcNOKSkLcFAd
         EVDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5BybgI3ufsI0ReTExyQ1WaZdrh94B7x8b54cBXkE0lk=;
        b=b03ec7dtetzpzysCEbvR0rfYDbU7jgUHm4jGv8VZ2iqyiBuhABBJOpgLFomJagKAIh
         OxOLoRUW8RfHJiY7SnCwACe2O722Ar5HvCXdCL03VQgTwy45Jp8DF0+U2TZt8lBBIGBc
         mVtrmgNzwxgzMBRLwuiT9zJPuN8C3qHcyvyo9YS6icPfohu0k5vfXin0Q2PaLNMyScEx
         zQ5IgMFLT2liX9ejTHU2cTDJuT6fVrt229LXiTSeFBljYtd0SWXdY41Gawrf12yE+b4t
         I+3fkkPX/dvKDvVtTTHee/O6YxUDUpwl/CKSm5NV1J8s48g7qZqtZ5CkHn0e3/L0tLHc
         FUlQ==
X-Gm-Message-State: AOAM53273RTXvrZB/ptO7oJt0ose+7VKT1iEIosQAngtOXEyq+X2jT5p
        snfMMZwdbFD6NwUpD/C9vytBFVQvrsU+M5u3
X-Google-Smtp-Source: ABdhPJwfkE7ywuTAwcLIIRKCtImmG1JJOnxawBiKojpW0mE1cC9Zf72FT1wBhd6y0AgBQThEKzwSfw==
X-Received: by 2002:a05:6214:19ed:b0:42c:289b:860e with SMTP id q13-20020a05621419ed00b0042c289b860emr1448255qvc.73.1646860966588;
        Wed, 09 Mar 2022 13:22:46 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id m6-20020ae9e006000000b0067d3e75e2a6sm898589qkk.19.2022.03.09.13.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 13:22:46 -0800 (PST)
Date:   Wed, 9 Mar 2022 16:22:45 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     dsterba@suse.cz, Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH v5 12/19] btrfs-progs: set the number of global roots in
 the super block
Message-ID: <YikapaHhZ41AFcmj@localhost.localdomain>
References: <cover.1646690972.git.josef@toxicpanda.com>
 <1c28a05081455379be5d91ee760f9a03e4255e6a.1646690972.git.josef@toxicpanda.com>
 <20220308161951.GN12643@twin.jikos.cz>
 <PH0PR04MB741601104CC2D56A2EF3C02C9B099@PH0PR04MB7416.namprd04.prod.outlook.com>
 <20220309170553.GY12643@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309170553.GY12643@twin.jikos.cz>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 09, 2022 at 06:05:53PM +0100, David Sterba wrote:
> On Tue, Mar 08, 2022 at 04:41:44PM +0000, Johannes Thumshirn wrote:
> > On 08/03/2022 17:23, David Sterba wrote: 
> > >>  	u8 metadata_uuid[BTRFS_FSID_SIZE];
> > >>  
> > >> +	__le64 nr_global_roots;
> > >> +
> > > 
> > > Shouldn't this be added after the last item?
> > > 
> > >>  	__le64 block_group_root;
> > >>  	__le64 block_group_root_generation;
> > >>  	u8 block_group_root_level;
> > >>  
> > >>  	/* future expansion */
> > >>  	u8 reserved8[7];
> > >> -	__le64 reserved[25];
> > >> +	__le64 reserved[24];
> > 
> > Or at least inside one of these reserved fields.
> 
> OTOH, it's still experimental so we don't expect backward compatibility
> yet so it should be ok to change for now.

I did it this way because it's all still experimental and it makes more sense
for it to be before the new root stuff.  Thanks,

Josef
