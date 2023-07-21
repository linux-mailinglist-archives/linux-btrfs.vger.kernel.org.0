Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 942BD75BBB2
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jul 2023 03:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjGUBHr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jul 2023 21:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjGUBHq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jul 2023 21:07:46 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F71C271C
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jul 2023 18:07:45 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-7683cdabd8fso120546785a.3
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jul 2023 18:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1689901664; x=1690506464;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wCKvULWGxKiZTX5HLNzhKfd0w/b6XrFMeOy50CpX1Tk=;
        b=T9woL99OxJ6TgYDNzpcpeTP6R9+qP/w8iZ8M+Y87riFGXeOUbPkQLYKyuJsSQ615Bd
         6fzQ3wmvX5TXnpVvnVcAeujSZgAbT2VG2Xlcx6YwkPoS4gzyNTLwg8GU1Yh01y86OkVw
         haSUv9ilYEfGHYEQIwd58qJ70sYg0019izwigxOP6tf4rAkUO9bKpNLT1gJTi9hAWnx5
         gzlCf6oil/sNf8+E364GUZLavJKOJ/U6fMs2xyhYgtuU/0xt1TOR7HphOQhtN78xbjQH
         B3We6Z56Xz3exzPI0Rm4ZrBblUv4HxMg95GE4N8VOrFgJfBdGeWzk+IgkuCXREoIPob6
         I2Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689901664; x=1690506464;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wCKvULWGxKiZTX5HLNzhKfd0w/b6XrFMeOy50CpX1Tk=;
        b=JOwTFgMS0Qymx+u4B/IsrF0CUQsJpvWEKstp4X4pr30Gy99HsAds60Zm8m8lBnVYnN
         x/q+dPPxweftyvhEMvuMt3Qe8cBkDMNZYvwqnGy1/Ig+5IIKvdCTTGWFyfyoN+08GBXo
         QRw8td+86VaidStSla2b9bYklM918JuDb/EJhY2ZOJMR+ew0tGT0CjoCFi+HP8p2qRyS
         FAl0HKeeizTUyHJChkjKVPFFH6T901pJp9dkTZmN+jFqoGt466W2zAU2lif1cAYdtQI/
         kPro6ZINWKHROKx/WCrEDQRPOiH3rkn1HwfVjcDNv8s66Z7WCeyUtXgkGmi8MCXXR5EC
         zblQ==
X-Gm-Message-State: ABy/qLYgH2vGzKc15w4XszPxDo7f6V3CqRYFC1rlMTeFLBOTKsCyMzp1
        cP+5KS/ELJK3fMr8RxBJzev21t8gX5AvbuyD2GTseA==
X-Google-Smtp-Source: APBJJlFqApKftxcumxKJZ8qjs8rRWy/23bH64182afzZdsOXwSY+KoNWUROM/dlMGwqx2HAIpSHDHQ==
X-Received: by 2002:a05:620a:472b:b0:765:abeb:a148 with SMTP id bs43-20020a05620a472b00b00765abeba148mr389283qkb.37.1689901664480;
        Thu, 20 Jul 2023 18:07:44 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d205-20020a0ddbd6000000b00577139f85dfsm568713ywe.22.2023.07.20.18.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 18:07:44 -0700 (PDT)
Date:   Thu, 20 Jul 2023 21:07:43 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 3/3] btrfs: cycle through the RAID profiles as a last
 resort
Message-ID: <20230721010743.GA1202486@perftesting>
References: <cover.1689883754.git.josef@toxicpanda.com>
 <4beedde9b4f6adf4a7054707617f8784e5ee8b35.1689883754.git.josef@toxicpanda.com>
 <20230720222817.GB545904@zen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720222817.GB545904@zen>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 20, 2023 at 03:28:17PM -0700, Boris Burkov wrote:
> On Thu, Jul 20, 2023 at 04:12:16PM -0400, Josef Bacik wrote:
> > Instead of looping through the RAID indices before advancing the FFE
> > loop lets move this until after we've exhausted the entire FFE loop in
> > order to give us the highest chance of success in satisfying the
> > allocation based on its flags.
> 
> Doesn't this get screwed by the find_free_extent_update_loop setting
> index to 0?
> 
> i.e., let's say we fail on the first pass with the correct raid flag.
> then we go into find_free_extent_update_loop and intelligently don't do
> the pointless raid loops. But then we set index to 0 and start doing an
> even worse meta loop of doing every step (including allocating chunks)
> with every raid index, most of which are doomed to fail by definition.
> 
> Not setting it to 0, OTOH, breaks the logic for setting "full_search",
> but I do think that could be fixed one way or another.
> 

Yeah lets drop this, a bunch of tests failed, I need to drop this and re-run and
see what happens.  I hate this code.  Thanks,

Josef
