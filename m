Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E58C94C6023
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Feb 2022 01:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbiB1AjI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sun, 27 Feb 2022 19:39:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiB1AjG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 27 Feb 2022 19:39:06 -0500
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F19B31515
        for <linux-btrfs@vger.kernel.org>; Sun, 27 Feb 2022 16:38:27 -0800 (PST)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 3337E92164E;
        Mon, 28 Feb 2022 00:38:27 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id 53F9F921965;
        Mon, 28 Feb 2022 00:38:26 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1646008706; a=rsa-sha256;
        cv=none;
        b=lAXe8eIJcAx95lTWuE9vQFzhMoXLZd8jbuKrMT34MXA0TDFXXBSpdUe2yBMSoQtkQSdnyA
        S4USNyQsjgDk7poGygs3vHEsLQBGHCfXwO8lq4lTDaL/HSYOKXVRmuwEq8fAlQbT5gw+Pf
        jAt+l+yvQiNHKGVuygd3VeinMc4R7AZmLBAaB6M2FxMRG3+5i9b/8KKI2Zfg8YdM624F4X
        0Kgie0/5wgXl8bWH1NBFkHKJyVWnUo9nI+Pj8MmkeQhJ0EezCNsd6vwFcK7aUdh+HwZa6h
        9Muz2SzVmK935gZ8Dyc42GYOKYVgAa/5r04KZroob6fP7GqH/ilZrA7Vf3RTUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1646008706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1yoqXGOfsOalKURKB5t42yK9AAvaO/7LR67vAMsS8aI=;
        b=9PiWpO8MdDZ5aEwSdkaMr/+LhHsK9XAJlP8hRXKqaQgpJgdh05p4/w/YOZb0mJ/e1ihk0F
        QQs+roRWL+qL2u0kRtgy/ABOZ+OtCbAky4S9drA7tYqV2d5nAQBg/48w4FALSYNy/of/HF
        Mt5XTYS3CalT/eIpENvgeW/iY0fvQ2VvebW1jAuhihUpg8iZy82bd7MIg8ld9AHDRVzJ40
        i+u0mQg6JINEd8iGV8qlK7XPmFWDw89UBV6J+uAkpWtmyUsBIhaNJ/9a7P0EBC20VgycsR
        kBlM++sYchDYFdbdp7lFxvRXkf3qUWhGfBCupSDBynM8od6DSKEzWQhw3RoSIg==
ARC-Authentication-Results: i=1;
        rspamd-c9cb649d9-ncc25;
        auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.121.92.75 (trex/6.5.3);
        Mon, 28 Feb 2022 00:38:27 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Shade-Minister: 604fd52154832876_1646008706989_2563537581
X-MC-Loop-Signature: 1646008706989:3461771555
X-MC-Ingress-Time: 1646008706989
Received: from ppp-88-217-35-91.dynamic.mnet-online.de ([88.217.35.91]:58796 helo=heisenberg.fritz.box)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <calestyo@scientia.org>)
        id 1nOU3Q-00066A-5B; Mon, 28 Feb 2022 00:38:24 +0000
Message-ID: <f7270877b2f8503291d5517f22068a2f3829c959.camel@scientia.org>
Subject: Re: BTRFS error (device dm-0): parent transid verify failed on
 1382301696 wanted 262166 found 22
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Date:   Mon, 28 Feb 2022 01:38:18 +0100
In-Reply-To: <5eb2e0c2-307b-0361-2b64-631254cf936c@gmx.com>
References: <2dfcbc130c55cc6fd067b93752e90bd2b079baca.camel@scientia.org>
         <5eb2e0c2-307b-0361-2b64-631254cf936c@gmx.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.43.2-2 
MIME-Version: 1.0
X-OutGoing-Spam-Status: No, score=-0.5
X-AuthUser: calestyo@scientia.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, 2022-02-28 at 07:26 +0800, Qu Wenruo wrote:
> I checked the transid:
> 
> hex(262166) = 0x40016
> hex(22)     = 0x00016
> 
> So definitely a bitflip.

Hmm... would be a surprise, since I copy loads of data over that
machine, which is always protected by some SHA512 sums.
But could of course be possible.

I assume you mean the bitflip would have happened when the data was
written? Cause reading it reproducibly causes the same issue.

But shouldn't a scrub have noticed that? That file was created around
January 2019, and since then I've had mad several scrubs at least.


> Please run memtest on the machine.

Will do so later.



Anyway... is it recommended to re-create the fs? Or is deleting the
file enough, if a fsck+scrub finds nothing else.


Thanks,
Chris
