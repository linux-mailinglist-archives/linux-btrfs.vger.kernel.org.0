Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1041F62C5DB
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Nov 2022 18:05:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238792AbiKPRE4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Wed, 16 Nov 2022 12:04:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238529AbiKPRES (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Nov 2022 12:04:18 -0500
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 368E956EFA
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Nov 2022 09:04:07 -0800 (PST)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id A51C75C19B5;
        Wed, 16 Nov 2022 17:04:04 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id BBCB55C1C7C;
        Wed, 16 Nov 2022 17:04:02 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1668618243; a=rsa-sha256;
        cv=none;
        b=LaZa9mfVtwLe0hovkIfnDs6aa0ynQ3MgShTLCHOuB6Y/S2TnSld6vU1CTdeeOhSenknuaa
        9oPRnCEVf4aYZD90lUKyKomHCNN8SiPqz3vd9hhQDqlM6jzWa91jxV0nKDYfB1m7kufFHa
        n3xeQG4OQVrJkucLwIcgYoBI1yMLNuCg9BeKNLjgKJK5HrfPs5dpdf/oeynevY53uFJ0nN
        sjVnlVQjn9qu1DmJdurdCcZz7zcH1HkzJfbwolRVpnj6pJb4NjN/h/LRMpTZ7+RRvFqJ8A
        a/ZdlmAmXws217OQ/ZZ37ih8j8Jnzxoq/42NcXFZkiItRFMYkqMmyLnXadU/4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1668618243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NSgR2lbSdKytDz/cwcwoeKaj++fBbQoDbU925zAI1+k=;
        b=GaokzBqvEsUPYvzmwtmzcOayUASkeo5aFOXOoLDjrkUrHF4HSZ0hXPUXy99+t2shoA2Nz5
        TX3lo2EbEVGdis2243zCSCx/eoLpgEe2XZ9Sx6VJoaNiv8QbAcTyFZgMJfVoJj45xcXa37
        9Y6jW5+CuWEHqvCOR53XJJbBya0LF0guSkyK9SWnont29/TwTQVK9wEWqvVHHnESZwhUJm
        12eiEGsr19USKvMepe7c6fpSo6G5TZmg144hO+9m/lI38wnt/JTzpyRpZ1ItiBpEvHtxK5
        LPQCmjdEw9/PEaAMMR/zs79cEIeVzJ1XbCmeKIwqA03AordOPR6NMpS7BHTLAg==
ARC-Authentication-Results: i=1;
        rspamd-7f9bbcf788-hxdfp;
        auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Cure-Stop: 57fac960483b376e_1668618244256_4017595040
X-MC-Loop-Signature: 1668618244256:2676578746
X-MC-Ingress-Time: 1668618244256
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.99.229.23 (trex/6.7.1);
        Wed, 16 Nov 2022 17:04:04 +0000
Received: from ppp-46-244-242-174.dynamic.mnet-online.de ([46.244.242.174]:59584 helo=heisenberg.fritz.box)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <calestyo@scientia.org>)
        id 1ovLpO-0004JK-Ml;
        Wed, 16 Nov 2022 17:04:01 +0000
Message-ID: <abf83660318efd4ceafaa3cea98371c1e6e9fa25.camel@scientia.org>
Subject: Re: [PATCH 0/3] btrfs-progs: receive: fix a silent data loss bug
 with encoded writes
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     linux-btrfs@vger.kernel.org
Date:   Wed, 16 Nov 2022 18:03:55 +0100
In-Reply-To: <CAL3q7H5iqfqPFwkLA+t3vFikVoZNMU-5h_F7iHmEJKqvVSp05w@mail.gmail.com>
References: <cover.1668529099.git.fdmanana@suse.com>
         <6e601151e5d290a6a6288928e9d8737aca82ed7b.camel@scientia.org>
         <CAL3q7H5VJM6GY5GN9zjOj3qPhPxRSZhtq8smZkBd4TVJ_vy7Nw@mail.gmail.com>
         <f2ccd7455a18b17b72846c61581db0fda5347829.camel@scientia.org>
         <CAL3q7H5iqfqPFwkLA+t3vFikVoZNMU-5h_F7iHmEJKqvVSp05w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.1-1 
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

On Wed, 2022-11-16 at 10:50 +0000, Filipe Manana wrote:
> There will always be users who'll miss such alerts, many don't read
> all the emails in this list, many are not even subscribed to the
> mailing list, etc.

Sure... and it will never be possible to have a system which really
reaches 100% of the desired users.

But this isn't only the case for a something that notices about data
corruption issues, it's also the case for any other warning system:
- civil defense via sirens (people may life to far away, wear
  headphones with loud music, be deaf, sleep with earmuffs) via apps
  (they often simply fail or are overloaded, people may not have a
  smartphone at all, it maybe powered off)
- software security advisories (again, people may not be subscribed to
  such mailing lists, may not run upgrades regularly respectively check
  for security updates in some automated fashion, or attackers may try
  to specifically block such information from certain people)
- etc. pp.
- and even *if* the information reaches someone, it's still not 
  guaranteed that he cares about or understands it well enough


I don't think the goal is ever about reaching everyone - the goal is
having a simple way of reaching those who care.

Because whether it's storage farm admins who keep important scientific
data on btrfs or some end user who values his precious collection of
pictures, etc. ... it would be quite good for them to be able to react
in cases of (especially silent) data corruption.

And I should emphasis, that this is in no way targeted for lazy people
who don't make backups.
I for example do have some rather sophisticated backup strategy, but if
there's silent data corruption it's often quite hard to tell whether
the data is still valid, even if one does things like storing hash sums
of them (and verifying these of some 10TB of data already takes several
days).


> Do you have examples of other projects that have an effective alert
> system?

Well, as I've said, not at the filesystem level. But it's e.g. common
practise for security incidents.


Upstream developers put quite some effort into finding and fixing such
bugs, which is appreciated, but IMO that is a bit ridiculed by the fact
that people then may still loose their data, just because they never
take notice about such issues, when they'd still have valid backups.


Cheers,
Chris.
