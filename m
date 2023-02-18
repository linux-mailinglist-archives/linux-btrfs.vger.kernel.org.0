Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E83369B6FF
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Feb 2023 01:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjBRAmg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Fri, 17 Feb 2023 19:42:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjBRAmf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Feb 2023 19:42:35 -0500
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4A283F7
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Feb 2023 16:41:58 -0800 (PST)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 3DE4320126A;
        Sat, 18 Feb 2023 00:29:32 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id 384FC2012C7;
        Sat, 18 Feb 2023 00:29:31 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1676680171; a=rsa-sha256;
        cv=none;
        b=mNDFRUThfpl4Xp9dlpiO9YeOiqrQaPPZKg95fZpjk+rhkzROxVwDYDExio9gBC6fAOvzfR
        HkG+OztoSpoRvunCV8MP1Gz0ZnVcRjAtqyw4PUOhZlsnWG3webX9kXh+YNvUr5EjyObBb8
        vXX+43ylaGaycc7T+YpAOuAKyp9+6aRN3JKpIaNPrKYlRvRdGbP/4Tc4AnSrYaxxs7oTu/
        7aF9WVCP6pFNqte5Oikpe8+EcT5ovb7FZ7HlvVjU6zy5tmn+uF9tvUnpR87atcnHDX2ZAS
        +q4SJ8/WmKd/Y6UJ0zuDRTfFEkkyGji1wdnMhEF6aqZLTqZe/SUe1tAi+qglFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1676680171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xLM8VOWP1AzSePQerox+yVpY4hrmQHIp8NkdC17njLs=;
        b=TtYmjLD98h7lT7CY80AYfb8hU0ZXtMesAniLl81ULBAB927ygANC3hlNfwdTgZsj0eiGFh
        QpOuyjiUjdL2vDOcC+dIea2t4TViOraT+R3OItyfsCYEZl9Kq5L9Lw0XK2RlIQwygOWW33
        qtD9oo+70esu+kG714ZV2OuQjOt84WIR2XZIaoqH9xbElmD8QPFfyUqGmEaNpj3DdJJHMz
        242BKnPfsAc4YIaRwa7HbxNpCD4sxy7sqkYVY4RjLuOpc8jrR3iJ9alvMH3WsmzC4UJN7x
        YpqsN8v4GKuCJDxTx35gi2N8hbsQUT0WH3T4KR94Up9bI3ubT3JCFoRe15h/Yg==
ARC-Authentication-Results: i=1;
        rspamd-9788b98bc-hzrxs;
        auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Cure-Relation: 6c1a493879b24cef_1676680171871_2320105499
X-MC-Loop-Signature: 1676680171871:3064075238
X-MC-Ingress-Time: 1676680171871
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.123.200.110 (trex/6.7.1);
        Sat, 18 Feb 2023 00:29:31 +0000
Received: from p5b071f3f.dip0.t-ipconnect.de ([91.7.31.63]:34178 helo=heisenberg.fritz.box)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <calestyo@scientia.org>)
        id 1pTB6U-0007uZ-SC;
        Sat, 18 Feb 2023 00:29:29 +0000
Message-ID: <b492bb2878c839b2ea9cb8a9c94124062e29f42d.camel@scientia.org>
Subject: Re: back&forth send/receiving?
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     Andrei Borzenkov <arvidjaar@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Date:   Sat, 18 Feb 2023 01:29:24 +0100
In-Reply-To: <c0e00d00-20ff-642f-bbfd-ecbd17669502@gmail.com>
References: <10fd619ccbe568df4344b6b1d93f061bc493d396.camel@scientia.org>
         <9a49ccb8-9728-029f-be0e-75ccb8e211d0@gmail.com>
         <3c77c6306ece13559de514940074ac70b4fc882a.camel@scientia.org>
         <a134a22a-80f2-91a5-f0a1-21145c487118@gmail.com>
         <bcb9bfe78715e98ea758df3723daa8f9afb2f20a.camel@scientia.org>
         <CAA91j0XNV68cuVmue7tuQDMZv7NirwWiJp1ntb1B9fKoSMKt-g@mail.gmail.com>
         <d02fb95aecf51439c7784c990784f73a11412e4b.camel@scientia.org>
         <c0e00d00-20ff-642f-bbfd-ecbd17669502@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.4-1 
MIME-Version: 1.0
X-OutGoing-Spam-Status: No, score=-1.0
X-AuthUser: calestyo@scientia.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, 2023-02-17 at 20:25 +0300, Andrei Borzenkov wrote:
> So copy1 and copy2 are identical. This is not what you said earlier
> (at 
> least, it is not how what you said earlier sounded).

Well that are based on the same master, but their most recent snapshot
from that *may* be a different one.

E.g.:

master could have:
data  (with the following snapshots of that)
data_2022-10-01
data_2022-11-01
data_2022-12-01
data_2023-01-01
data_2023-02-01

copy1 could have:
data_2022-10-01
data_2022-12-01
data_2023-01-01

copy2 could have

data_2022-10-01
data_2022-12-01
data_2023-02-01



> So are all copyN identical or not?

Well, except for perhaps the most recent snapshot.

The reason is in my case simply that I keep the copyN HDDs never at the
same place.... so there may be some time where on is not up to date.
And sometimes I may even skip a snapshot when I up date one of the
copyN HDDs, instead taking an already newer one.


> > But I always keep on (old) master the snapshot that are most recent
> > on
> > each of copyN, so that I can continue from there, when I do the
> > next
> > round of snapshot.
> > 
> 
> It does not matter what you keep on old master because old master is 
> gone. What matter is what you keep on each copyN.

That was meant for the time hen old master is still there any I make
the regular snapshots.
Of course I'll do the same on new master, too. Simply to be able to
incrementally send|receive to the copyN.


Cheers,
Chri.
