Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A82235E821E
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Sep 2022 20:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbiIWSxm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Fri, 23 Sep 2022 14:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232665AbiIWSxg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Sep 2022 14:53:36 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3975412113F
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Sep 2022 11:53:34 -0700 (PDT)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 0E6778219EA;
        Fri, 23 Sep 2022 18:53:34 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id 449A98207E9;
        Fri, 23 Sep 2022 18:53:33 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1663959213; a=rsa-sha256;
        cv=none;
        b=tpRyoOqOn5+G0xuUUmM3QerE51RbLAXRf9wucXTDo9mlvrqedID49nrQzbuVpCgC2Q5YCK
        UmdHoPzIb7kUF4QtrjlhJI5ivn7wbzSkINicS6CF8aq0yQCRfnTLyHxtQxKDOga3Uv2xQe
        9NrUw+bCPi3txy+U5QCUFgVg8xbBFUEtV/pbqefZ9HEN4mFoSYobxgPnj2fLsecHyzpZEx
        vVAaauJGQquX1NKRVGvacVjfiJTEfi8+Lb1/h1kleph9105KbmyDAe5m+K1B7fwqKqAn4L
        dCVfgux333qPcmD55Aukw7RzF2QsKQ9NICduUXlDUQc/2UB0RAHR3YArlQMrwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1663959213;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=loiIiRc67RlHcrWLOnsRHl9P4YjbVboyzHc3dXY0AKo=;
        b=IswEHPX0/VBRU5gHm4mlm/1P8rSNhHORdeoN8HpW3BZ4iAbfH6qfpEZDSeRqnfisJnQgNh
        HUzWzAmHO5OWYXDQI47Z/xjhdicqNf8muuyYb2dSc+dFN4J5Gg/LkYSTnd/xRu0aU9nCwp
        E7NDDXn8pSqB7IxIVNmwZmOJs8EDGtx+jAjMiQVXmTD4g2snuNyeXVr4D3p8QB9AigYVQB
        9VlNr62GeMGsIsO+guSM4iGs+Jccxbwrqf3LhBNwVQOcPSjp7SC24Oh3de+shfJp/XDoAc
        1uDcy6k82URKNgyDDnGeJq6Bf7YWCjtx10ZaNlAbbXxk0ox1bYxwa0c8hCIrAw==
ARC-Authentication-Results: i=1;
        rspamd-7c485dd8cf-ng7fn;
        auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Arithmetic-Illustrious: 0456db8f5633bd89_1663959213729_1240439065
X-MC-Loop-Signature: 1663959213729:4280716135
X-MC-Ingress-Time: 1663959213728
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.97.77.221 (trex/6.7.1);
        Fri, 23 Sep 2022 18:53:33 +0000
Received: from p54b6dffd.dip0.t-ipconnect.de ([84.182.223.253]:58514 helo=heisenberg.fritz.box)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <calestyo@scientia.org>)
        id 1obnnm-0000lD-Lh;
        Fri, 23 Sep 2022 18:53:31 +0000
Message-ID: <71898f735214914a06772ee838b030aef0f436ff.camel@scientia.org>
Subject: Re: call trace when btrfs-check tries to write on ro-blockdev
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Date:   Fri, 23 Sep 2022 20:53:26 +0200
In-Reply-To: <4d8f3ce4-f488-d065-ef7e-c7705ac4efee@gmx.com>
References: <70591e96d9dbc46cfaa44316f0eb1bcccc7017f5.camel@scientia.org>
         <6d72763c-d024-3224-be8e-0ade32540883@gmx.com>
         <52bf0daaa1f88fe1069f4871e28ca18a90d1d5c1.camel@scientia.org>
         <4d8f3ce4-f488-d065-ef7e-c7705ac4efee@gmx.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.0-2 
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

On Fri, 2022-09-23 at 18:39 +0800, Qu Wenruo wrote:
> Got the reason.

As so often:

thanks for your efforts :-)


Cheers,
Chris.
