Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D377860EF6B
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Oct 2022 07:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233705AbiJ0FQD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Oct 2022 01:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233187AbiJ0FQB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Oct 2022 01:16:01 -0400
Received: from hz.preining.info (hz.preining.info [IPv6:2a01:4f9:2a:1a08::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C43CAD18E0
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Oct 2022 22:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=preining.info; s=201909; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=1mEsh8jZ4/nbQ/zMUp4SaLGBqBruz32cLuruZpb1nx4=; b=hSgVrClfgbMEeBQ1sTZk/2Zguu
        leFp7VhXIv+6vZOPtVjAPRpCap5sKtU/C+3XpaW6uhtpxHO2LcutQ/x9pUJH2BPM9rLBMrENnBhwD
        qp/51TOhJUS2zqKRpIyH2tCtjr9CEV/wkCvyFdHfaAQbF8vCP6q7Yf4CcfOqCX4ALTeZVP5mj54ox
        C1I49pxBWKWkFzs0Tr7sV2CZgsmJWHwa9Xn2BL4mfBJUOI/iXwZ07c7yW5Sc/uaMsRrBgYec3sIej
        pnRNVCyqc6qgAf6hk7TwWevO27vmMLE01oUv5Yflm/mzWp9pymvxdanMwKeuuuW43/kn9PqJg4NDz
        iUWMTEAQ==;
Received: from tvk215040.tvk.ne.jp ([180.94.215.40] helo=bulldog.preining.info)
        by hz.preining.info with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <norbert@preining.info>)
        id 1onvFF-005QSd-EX; Thu, 27 Oct 2022 05:15:57 +0000
Received: by bulldog.preining.info (Postfix, from userid 1000)
        id 0BF6BDFA069; Thu, 27 Oct 2022 14:15:53 +0900 (JST)
Date:   Thu, 27 Oct 2022 14:15:52 +0900
From:   Norbert Preining <norbert@preining.info>
To:     Christoph Anton Mitterer <calestyo@scientia.org>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: Lenovo X1 - kernel 6.0.N - complete freeze btrfs or i915 related
Message-ID: <Y1oUCLPC8xqrm1j1@bulldog>
References: <Y1krzbq3zdYOSQYG@bulldog>
 <5d59652451decb86786ff2dff9e4ffe3843f143b.camel@scientia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d59652451decb86786ff2dff9e4ffe3843f143b.camel@scientia.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi

(please cc)

> https://bugs.archlinux.org/task/76266

After booting an emergency system, running btrfsck with csum verification,
and mounting with clear_cache,space_cache=v2 I still had problems with the
kernel 6.0.3.

After compiling 6.0.5 on a different system and installing it via the
rescue system, it *seems* now that everything is back to normal.

Thanks, much appreciated

Norbert

--
PREINING Norbert                              https://www.preining.info
Mercari Inc.     +     IFMGA Guide     +     TU Wien     +     TeX Live
GPG: 0x860CDC13   fp: F7D8 A928 26E3 16A1 9FA0 ACF0 6CAC A448 860C DC13
