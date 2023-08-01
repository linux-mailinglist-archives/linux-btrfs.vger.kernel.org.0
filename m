Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A312076B8BE
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Aug 2023 17:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234831AbjHAPiY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Aug 2023 11:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234933AbjHAPiW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Aug 2023 11:38:22 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2473212A
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Aug 2023 08:37:57 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6bb07d274feso4687474a34.0
        for <linux-btrfs@vger.kernel.org>; Tue, 01 Aug 2023 08:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1690904277; x=1691509077;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rweJ08k36JhZyaWh/Pxz3o+M4bljy5VfL8MZUt6j5oI=;
        b=Slpu82+CAkN2Lwcv48X+34VVShswTvPLNBPXNLqAU+6OSSxA7+GDLo0uahMj2AvMC6
         ljZyBBfWZQ6+GorrJWHNcbSzKG02qqH0ay8ytvhoBZxD7kLQ+X/f2jVMtTrCok9Wjoy3
         6GOes+7kDQw5lFJdBOMXfINCSymZCFMo6bRQpziajkWXDvoCXNwyye9PtyfhkkzYFI1S
         5AAanpLmfna+lCOdw/eysp6z+vrprq7awGdKRXZt/iPF8ULE/wTXf4e7lxdUAORBxLbH
         H7Cn4adbUlbu7rCPWuQuxjrJNoUNl1TDLeaDFNb3yv3zuDIKTImCWcbLyiuupPcEZ4HM
         /hkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690904277; x=1691509077;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rweJ08k36JhZyaWh/Pxz3o+M4bljy5VfL8MZUt6j5oI=;
        b=FbmVSCW8TA9k73cbTIXR6mF9qlqjlmDlhqCXYjYxtYKdM/81A4aZRNjJC1LRgmA3K3
         RBmNI2VcfsJ0ulVjmqivGsOggKQ3d/lNPFyrmgVx9gzEz3roANgRgbk86m25WQwGdVR4
         pNDGqlrYYHSYVSY3sHCZ4MrOuWbFodhU8qa2merUZZaGZrlIzcXxhkTiX7Sl7nuj4phq
         4OBf1jNn2OwiR2NkMtG6kALXm8WVmBP209ef4p8h+usG/1sMPVbcS32M6yMdnV8lt6Y2
         KvWaH+TcdiEmPl6BoS4U1ydkSHNZa8xmj6S/JF5A5wagXqR1r9MFDEdwTslA2P+ti+CM
         MQHw==
X-Gm-Message-State: ABy/qLYlFcBnJoF4IHMXfGS6WSn5OdV+StuafUz1GZ7xeG7P/k9DAFxF
        oRhn/T91LdH0t6koW2SPj2OPyRzJ8AxEjpq1kf49bA==
X-Google-Smtp-Source: APBJJlHvrZYHJ9aYSvYfmgHPmTZrS3jZXToSykFYNFyqAL0ZtSNgIwMiMP6CmNSBFyP2HCwMP7aj2A==
X-Received: by 2002:a9d:7d8c:0:b0:6b5:6b95:5876 with SMTP id j12-20020a9d7d8c000000b006b56b955876mr13263041otn.25.1690904276800;
        Tue, 01 Aug 2023 08:37:56 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id u18-20020a05622a14d200b003f3937c16c4sm4483636qtx.5.2023.08.01.08.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 08:37:56 -0700 (PDT)
Date:   Tue, 1 Aug 2023 11:37:55 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     David Sterba <dsterba@suse.cz>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        boris@bur.io
Subject: Re: small writeback fixes v2
Message-ID: <20230801153755.GA2013469@perftesting>
References: <20230724132701.816771-1-hch@lst.de>
 <20230727170622.GH17922@twin.jikos.cz>
 <20230801152911.GA12035@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801152911.GA12035@lst.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 01, 2023 at 05:29:11PM +0200, Christoph Hellwig wrote:
> On Thu, Jul 27, 2023 at 07:06:22PM +0200, David Sterba wrote:
> > On Mon, Jul 24, 2023 at 06:26:52AM -0700, Christoph Hellwig wrote:
> > > Hi all,
> > > 
> > > this series has various fixes for bugs found in inspect or only triggered
> > > with upcoming changes that are a fallout from my work on bound lifetimes
> > > for the ordered extent and better confirming to expectations from the
> > > common writeback code.
> > 
> > I've so far merged patches 1-3, the rest will be in for-next as it's
> > quite risky and I'd appreciate more reviews.
> 
> So who would be a suitable reviewer for this code in addition to Josef?
> 
> Any volunteers?

Boris volunteers.  Also I'll queue this up in the CI testing thing, I had done
it with your first submission but hit all the other bugs I've been fixing.  It
didn't hit anything we didn't hit without your patches so I assume they'll do
fine, but we'll find out in a couple of hours.  Thanks,

Josef
