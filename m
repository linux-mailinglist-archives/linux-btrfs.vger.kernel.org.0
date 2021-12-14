Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7D7474CB3
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Dec 2021 21:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234714AbhLNUfk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Dec 2021 15:35:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237657AbhLNUfj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Dec 2021 15:35:39 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B352C061574
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Dec 2021 12:35:39 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id u16so18415181qvk.4
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Dec 2021 12:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DypEDe+W4llGtwOyBEWx+X8HULbYvgxT6h2vkqMSC0I=;
        b=xHikJ3Zpi6CW8kXLRMius/iUDvXYJbGB2dqZlGLM8OtQrkkmRS15yF1Sed1yrjg5hn
         gMZhzwv47hJEKDUo3m3+Ta7JJtHdob/VvwQn3MXL/iiS3+pA7cywAMwSOZqgK86x4Gse
         0T0uwFbRWVx8xCsKEyGJC2S8FdOVXyFFm9/gfvSeL+fPYpCjzhugBtb+/J2VOHsZl9Me
         V7gOUJqzmHgvH1VO+LTftMclIP878o9AYPGSGP/77cH6gm7TtpK8Qvfcb2KJrlDehd16
         TeVhKhpUTBV7saL54cbDDXGnzYVY/KarCZMlxqWxCked4tTE9pXSFSuvSEv+GXFyJcS3
         rj6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DypEDe+W4llGtwOyBEWx+X8HULbYvgxT6h2vkqMSC0I=;
        b=Jjo2K/YjrCWnsSPmLBx63JNPNQ1QA5OX754ubEOxNR2tkSWN7ImVwCaGj9wxlrnBCC
         wkI4Enq05BKlUsVqMXZoKfewLtK93JeoftjCV9f6s1UuvHPsj4Qf7T6EDH3vgEOllrRo
         hhGhgMltyWVO3evLWwoo8lZknkesGgJUKIivyvPl9d53A0BTBGweSdnqXeXQR3VRsokm
         vc92PTpr1vcHjEEweHGO38dvSpC3nhSwfvZ1r9Qpxv9st0GM769pWRGiTrA1c0YQXkKU
         lrhG2NYOkPJGIkz2I+hiQvoxKxacIgeJv4T0FralnpGS9RJq1mBioVk+cZc9g1OnQnJT
         1bsQ==
X-Gm-Message-State: AOAM533rC7PHNq7iwXNJh0AtGWeBZMtNjm1jxC11RG+nENBLSI+edl3P
        6kVky4TJLcvyKVEJ9ZPVxzxatg==
X-Google-Smtp-Source: ABdhPJzR0d1XeVwieKQ+aoGkKMOs4Yz8VfpjdTOxQ5UQdutEpq2bSQYfjXf3c4PjO1tzT+Juuwjs8w==
X-Received: by 2002:ad4:5cac:: with SMTP id q12mr8254190qvh.52.1639514138554;
        Tue, 14 Dec 2021 12:35:38 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id g14sm710077qko.55.2021.12.14.12.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 12:35:38 -0800 (PST)
Date:   Tue, 14 Dec 2021 15:35:36 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     kreijack@inwind.it
Cc:     David Sterba <dsterba@suse.cz>,
        Sinnamohideen Shafeeq <shafeeqs@panasas.com>,
        Paul Jones <paul@pauljones.id.au>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Subject: Re: [RFC][V8][PATCH 0/5] btrfs: allocation_hint mode
Message-ID: <YbkAGOhOdyJpO/2F@localhost.localdomain>
References: <cover.1635089352.git.kreijack@inwind.it>
 <SYXPR01MB1918689AF49BE6E6E031C8B69E749@SYXPR01MB1918.ausprd01.prod.outlook.com>
 <1d725df7-b435-4acf-4d17-26c2bd171c1a@libero.it>
 <Ybe34gfrxl8O89PZ@localhost.localdomain>
 <97c118df-e7ec-1ef5-8362-e0ecc949db35@libero.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97c118df-e7ec-1ef5-8362-e0ecc949db35@libero.it>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Dec 14, 2021 at 07:53:34PM +0100, Goffredo Baroncelli wrote:
> On 12/13/21 22:15, Josef Bacik wrote:
> > On Mon, Dec 13, 2021 at 08:54:24PM +0100, Goffredo Baroncelli wrote:
> > > Gentle ping :-)
> > > 
> > > Are there anyone of the mains developer interested in supporting this patch ?
> > > 
> > > I am open to improve it if required.
> > > 
> > 
> > Sorry I missed this go by.  I like the interface, we don't have a use for
> > device->type yet, so this fits nicely.
> > 
> > I don't see the btrfs-progs patches in my inbox, and these don't apply, so
> > you'll definitely need to refresh for a proper review, but looking at these
> > patches they seem sane enough, and I like the interface.  I'd like to hear
> > Zygo's opinion as well.
> > 
> > If we're going to use device->type for this, and since we don't have a user of
> > device->type, I'd also like you to go ahead and re-name ->type to
> > ->allocation_policy, that way it's clear what we're using it for now.
> 
> The allocation policy requires only few bits (3 or 4); instead "type" is 64 bit wide.
> We can allocate more bits for future extension, but I don't think that it is necessary
> to allocate all the bits to the "allocation_policy".
> 
> This to say that renaming the field as allocation_policy is too restrictive if in future
> we will use the other bits for another purposes.
> 
> I don't like the terms "type". May be flags, is it better ?

Sure, rename it to flags and make the allocation policies flags.  The important
part is that "type" isn't accurate, and since it's not used by anything
currently we're free to rename it so it better represents the information it
holds.  Thanks,

Josef
