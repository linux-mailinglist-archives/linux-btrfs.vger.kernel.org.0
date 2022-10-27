Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5F360F1CD
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Oct 2022 10:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234843AbiJ0IGR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Oct 2022 04:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234771AbiJ0IGE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Oct 2022 04:06:04 -0400
Received: from hz.preining.info (hz.preining.info [IPv6:2a01:4f9:2a:1a08::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B5D5B7A2
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Oct 2022 01:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=preining.info; s=201909; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=zNGti7+DrBTz5y4SWRpBh6MARoEYAcnikyc9pt2QHts=; b=I592WOPbftXNXyAPkdveaxbq+Y
        z7db/1Hdd5IwrL8Gx3crwC6eEB6wnO0WHnYChQZApGp1f3Rp1mSNehDnmZh9QlnryCM66v/svZ0PC
        xGBSB0R5qBn6DrVu/OrsDFpY+CnlZ6K8tKElDMNxYzMXkoU6tk2WaBcms/GW3oNev5sf33YzERjoK
        X373gbESDR69U4LDSJCL8epXUD/hXBu75NmVkQtcjKWhlpiLzjsWbwk9W/7V1MVBT92C8qdjzxhYN
        N4Zg9kLUDxirJGqD68NUuZlrxyCrROjQjlKbCTQGFPxTAh+LHcG74mEpYVhqlcYTHRjC/BfOtI2Xr
        I+G9swFg==;
Received: from tvk215040.tvk.ne.jp ([180.94.215.40] helo=bulldog.preining.info)
        by hz.preining.info with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <norbert@preining.info>)
        id 1onxtT-005WGG-N6; Thu, 27 Oct 2022 08:05:39 +0000
Received: by bulldog.preining.info (Postfix, from userid 1000)
        id 37464DFA072; Thu, 27 Oct 2022 17:05:35 +0900 (JST)
Date:   Thu, 27 Oct 2022 17:05:35 +0900
From:   Norbert Preining <norbert@preining.info>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     Christoph Anton Mitterer <calestyo@scientia.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: Lenovo X1 - kernel 6.0.N - complete freeze btrfs or i915 related
Message-ID: <Y1o7z/yKVEfbw05M@bulldog>
References: <Y1krzbq3zdYOSQYG@bulldog>
 <5d59652451decb86786ff2dff9e4ffe3843f143b.camel@scientia.org>
 <Y1oUCLPC8xqrm1j1@bulldog>
 <CAL3q7H6yYSGRBtWa69-qM+6UjzpTXQspWtXDc=FTKtv2kSivMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H6yYSGRBtWa69-qM+6UjzpTXQspWtXDc=FTKtv2kSivMg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

> Your log showed only i915 problems:

Yes, because the btrfs error forced a complete hang without a way to
capturing the errors, but I have a photo, and put in the first two
lines of the backtrace.

But the issue seems to be resolved with 6.0.5 and some rescue booting.

Concerning the i915 error, that is reproducible. I will contact
the  maintainers.

> If that persists, just contact the i915 developers and maintainers:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/MAINTAINERS#n10214

Thanks and all the best

Norbert

--
PREINING Norbert                              https://www.preining.info
Mercari Inc.     +     IFMGA Guide     +     TU Wien     +     TeX Live
GPG: 0x860CDC13   fp: F7D8 A928 26E3 16A1 9FA0 ACF0 6CAC A448 860C DC13
