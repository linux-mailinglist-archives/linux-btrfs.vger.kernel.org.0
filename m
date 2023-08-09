Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E037C776A6F
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Aug 2023 22:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbjHIUlS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Aug 2023 16:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjHIUlS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Aug 2023 16:41:18 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D3EB4
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Aug 2023 13:41:17 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-7659cb9c42aso17260185a.3
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Aug 2023 13:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1691613676; x=1692218476;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v1cYipNmTpYZndxASQOi5v4ubGqHxZM9CIZ2bXvDXFg=;
        b=ITDvAYvQIKjoMjBkuP1lZ/1NSXBl9bU29SNXaiehVWLg0LIQhsciV1Hnc75zGOBk3V
         QLllFDD83XCYXr70MJ90YzRJdOk6MHv9jh4dxgorPGApVW4ZyEurt4kGQYb7y/Aj7wOC
         6N41lwj/R7qRwTErV1CYl3+LXpO3c+1NJmcS/lyCGETb25oYvsPSOwAU01BFjlpdHs6p
         5t0vEBOTbNsAHye99fSkmZM/ygE8n4/HXRn0RA3regyZv7sbC5s4Aq7nNRtO7ZdHTqtJ
         J0ib77soWczd8ygEfUPHyu4d5XRWcdgvEyvtaXZEBsR+XA3CiBqskQ1VVVS5KRO3cP/L
         9QAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691613676; x=1692218476;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v1cYipNmTpYZndxASQOi5v4ubGqHxZM9CIZ2bXvDXFg=;
        b=GrX13ZuCTzfqJZaIrEWrV+utDpgj7H1rPZdmSJMRUgXhYVwMSvznuri9Mn8cTkYrOA
         kGc0Fb+59Gpdoa+900Y7yeOX0KjCu5lGTnhKuYOZXrjph11hNlGKryhg1JuLw5pMLQMg
         RAW4C19l7ZkAMwZB2zCJ2rBiOMz805l9kwwLUCkTpYsZx0wNJMFrtuBc7s4Y8fUliTyE
         SFp+wj9QUmDkGQjjj0ICYFZEnNYyQBOYpNl5pzWlBeV1WizCYeEmWG2X5rwyu6XjF39q
         fn/H/FeWKsEIp2SUcu6liwZXFPxkFrN2yEhz66OvYBMoIfQ1Pcgu5D2en5AfnTNR94p5
         UHdw==
X-Gm-Message-State: AOJu0YxBrZqqkNlgEUiK89TSc5/SHBHyNHi5Af5qvfk2jATJlvTqI3gJ
        4BNVwNPSgdprlILbLa8EqH9CJQ==
X-Google-Smtp-Source: AGHT+IFRhbTanV6UWRb/7etz5kaKJ+rMxtOiv/exh3v2yOM4MRzzyXcVg/WWOkCUCNj9S/LLRoCvig==
X-Received: by 2002:a05:620a:2545:b0:76c:d9e9:541 with SMTP id s5-20020a05620a254500b0076cd9e90541mr168205qko.78.1691613676702;
        Wed, 09 Aug 2023 13:41:16 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id g16-20020ae9e110000000b0076cb0ed2d7asm4228723qkm.24.2023.08.09.13.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 13:41:16 -0700 (PDT)
Date:   Wed, 9 Aug 2023 16:41:15 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Cc:     linux-btrfs@vger.kernel.org, ebiggers@google.com,
        kernel-team@meta.com
Subject: Re: [PATCH v2 0/8] btrfs-progs: add encryption support
Message-ID: <20230809204115.GF2561679@perftesting>
References: <cover.1691520000.git.sweettea-kernel@dorminy.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1691520000.git.sweettea-kernel@dorminy.me>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 08, 2023 at 01:22:19PM -0400, Sweet Tea Dorminy wrote:
> This is the progs side of the encryption feature [1]. The first four
> changes are attempts to replicate the relevant kernel changes precisely
> to the equivalents in kernel-shared; the next four add support to check
> and dump-tree.
> 
> [1] https://lore.kernel.org/linux-btrfs/cover.1691510179.git.sweettea-kernel@dorminy.me/
> 

You can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

to the series.  Thanks,

Josef
