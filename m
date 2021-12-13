Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 353A6473672
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Dec 2021 22:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238970AbhLMVPT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Dec 2021 16:15:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237803AbhLMVPT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Dec 2021 16:15:19 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E12C061574
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Dec 2021 13:15:19 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id m186so15167793qkb.4
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Dec 2021 13:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=M7wocDf9UlytuxthBREdpjvMJva3XqI43EJo0/Yjp/s=;
        b=it+vAvc9MuE47qaplk/cuf+bdLqSvHkxL92GRJXaOpukToSqghcl01BFfCdNJfRTdx
         1YZGuVQ2MJdf3zkNVAZQxrcahkTy3fpH1zl6/0haoDgpe51Ecv/j43YiiHAU1oBG0dzf
         WbR9RFkOjCK8P7MhQ7fNoJlLD7HhkLgk1LrT4NI04sx74afBfsfW7hVc6IdXM3OsMo70
         cH/KbQYJnHtCYp8p82HFhrcqvm4h2kSwDxwbDz5wIEnRAY56gX/Dk7dUUjDitMcPLCWS
         Ur5kri1/V/VceCLe5tsMa2Y0XQFhcA+sGWTEuu9IKlH1qZf9aFs1Vu8WFTOTdbrlVEGl
         s5ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=M7wocDf9UlytuxthBREdpjvMJva3XqI43EJo0/Yjp/s=;
        b=UnxwxkYCuPD4Yq8sYGozS455LX77q066+f7cziw5WmrTTmPpv9h8kdBMx94Bi0isWh
         0GoFAF6J6XWHFmK0+i8wZXQlIkSXpc8mo39PcVv0bO6PpDXtTm9ZZ0AdfIFr0/JeawaY
         1vxvsd3nhms+TfVIJnGPGBiEkUIEfttrT+9xN8BPAvATPaeTAqNwizRBBybNlGgrwh26
         KB3UPJ18kJMznuo+QHrw6RBIWXLmdZaNVCqYxVxpZKSbpmxDyCTabWI/b9Tw8UN8vBFi
         zgPJPK7gn1cnG+yeOwQAobn7ah8feGG+fhz+LPT8npIEYVWdcZVf5XOFLgFOn/jVmOEM
         hCPA==
X-Gm-Message-State: AOAM530uqk1JfAUNsiT/UHbNIHOQqzChv1m9B1CyfA+1CVvYFnZE2M/b
        64TUQGOlpM45zWEpy7rncOw1mw==
X-Google-Smtp-Source: ABdhPJyB7QYadqsIdj3XwoNwcXWVih896gNO/TKaqiAXWENUySg+NtNq2vLR+V2zNJrz2X+nXT8BMQ==
X-Received: by 2002:a37:410:: with SMTP id 16mr686790qke.672.1639430117953;
        Mon, 13 Dec 2021 13:15:17 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v12sm6407835qkl.50.2021.12.13.13.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 13:15:16 -0800 (PST)
Date:   Mon, 13 Dec 2021 16:15:14 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     kreijack@inwind.it
Cc:     David Sterba <dsterba@suse.cz>,
        Sinnamohideen Shafeeq <shafeeqs@panasas.com>,
        Paul Jones <paul@pauljones.id.au>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Subject: Re: [RFC][V8][PATCH 0/5] btrfs: allocation_hint mode
Message-ID: <Ybe34gfrxl8O89PZ@localhost.localdomain>
References: <cover.1635089352.git.kreijack@inwind.it>
 <SYXPR01MB1918689AF49BE6E6E031C8B69E749@SYXPR01MB1918.ausprd01.prod.outlook.com>
 <1d725df7-b435-4acf-4d17-26c2bd171c1a@libero.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d725df7-b435-4acf-4d17-26c2bd171c1a@libero.it>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Dec 13, 2021 at 08:54:24PM +0100, Goffredo Baroncelli wrote:
> Gentle ping :-)
> 
> Are there anyone of the mains developer interested in supporting this patch ?
> 
> I am open to improve it if required.
> 

Sorry I missed this go by.  I like the interface, we don't have a use for
device->type yet, so this fits nicely.

I don't see the btrfs-progs patches in my inbox, and these don't apply, so
you'll definitely need to refresh for a proper review, but looking at these
patches they seem sane enough, and I like the interface.  I'd like to hear
Zygo's opinion as well.

If we're going to use device->type for this, and since we don't have a user of
device->type, I'd also like you to go ahead and re-name ->type to
->allocation_policy, that way it's clear what we're using it for now.

I'd also like some xfstests to validate the behavior so we're sure we're testing
this.  I'd want 1 test to just test the mechanics, like mkfs with different
policies and validate they're set right, change policies, add/remove disks with
different policies.

Then a second test to do something like fsstress with each set of allocation
policies to validate that we did actually allocate from the correct disks.  For
this please also test with compression on to make sure the test validation works
for both normal allocation and compression (ie it doesn't assume writing 5gib of
data == 5 gib of data usage, as compression chould give you a different value).

With that in place I think this is the correct way to implement this feature.
Thanks,

Josef
