Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B17D54976EB
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jan 2022 02:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240735AbiAXBsP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 23 Jan 2022 20:48:15 -0500
Received: from eu-shark2.inbox.eu ([195.216.236.82]:34808 "EHLO
        eu-shark2.inbox.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238668AbiAXBsO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 23 Jan 2022 20:48:14 -0500
Received: from eu-shark2.inbox.eu (localhost [127.0.0.1])
        by eu-shark2-out.inbox.eu (Postfix) with ESMTP id 277651E00049;
        Mon, 24 Jan 2022 03:48:13 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.eu; s=20140211;
        t=1642988893; bh=J7Id9iPM6i/IA+c7UmULozHJu3JcPpC9aOMgQOPpeEM=;
        h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
         Content-Type:X-ESPOL:from:date:to:cc;
        b=grvRd4IrxaFYheoyv8mwSrem7Za0K+0aD4X5o0sqsZDjCP04hDVgm5anUonRzFO0T
         6evwDfC3Dqx1lmHni0sTO2pRvRnWS0unaiqyCohB77+1XIaW2uIgdQaMKUKirxmuwT
         0vqZpdK+BUoqzHVAz6KSFnT0cR3refd7kzn2jFEw=
Received: from localhost (localhost [127.0.0.1])
        by eu-shark2-in.inbox.eu (Postfix) with ESMTP id 1E7271E0003F;
        Mon, 24 Jan 2022 03:48:13 +0200 (EET)
Received: from eu-shark2.inbox.eu ([127.0.0.1])
        by localhost (eu-shark2.inbox.eu [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id hHKzu1xJAwyw; Mon, 24 Jan 2022 03:48:12 +0200 (EET)
Received: from mail.inbox.eu (eu-pop1 [127.0.0.1])
        by eu-shark2-in.inbox.eu (Postfix) with ESMTP id B45D01E00033;
        Mon, 24 Jan 2022 03:48:12 +0200 (EET)
References: <CAKDzk=-HZardsLFH5c9HYre73NYNszUJqpfsh0YJnnaQToB3BA@mail.gmail.com>
 <1828959.tdWV9SEqCh@arch>
User-agent: mu4e 1.7.0; emacs 27.2
From:   Su Yue <l@damenly.su>
To:     Diego Calleja <diegocg@gmail.com>
Cc:     linux-btrfs@vger.kernel.org, Andrei Bacs <andrei.bacs@gmail.com>,
        cpu808694@gmail.com, Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Kaveh Razavi <kaveh@ethz.ch>,
        "Bacs, A." <a.bacs@vu.nl>
Subject: Re: inline deduplication security issues
Date:   Mon, 24 Jan 2022 09:38:48 +0800
In-reply-to: <1828959.tdWV9SEqCh@arch>
Message-ID: <1r0xx5tj.fsf@damenly.su>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: OK
X-ESPOL: 885mlYpNBD+giECgR3rABwYzs0g6UeX5iJS3qn1F/g/3MCiEf0oFUxGzm3AFM3H44X8X
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On Sun 23 Jan 2022 at 20:18, Diego Calleja <diegocg@gmail.com>=20
wrote:

> El s=C3=A1bado, 22 de enero de 2022 19:42:47 (CET) Andrei Bacs=20
> escribi=C3=B3:
>> We have found security issues with inline deduplication in=20
>> storage
>> systems, using ZFS and Btrfs and running examples. See the=20
>> attached
>> paper for details.
>
> (Not actually a btrfs developer here)
>
> I am confused, Btrfs does not support inline deduplication. The=20
> inline
> deduplication implementation used in that paper is pretty old=20
> and as far as I
> know it's not maintained (people seem to be happy with out of=20
> band
> deduplication).
>
> You might want to contact the developer on the inline=20
> implementation: https://
> lore.kernel.org/linux-btrfs/20181106064122.6154-1-lufq.fnst@cn.fujitsu.co=
m/
>
AFAK, Fujitsu has no more plans about btrfs.
So there is no follow-up version of the inline deduplication=20
feature.

--
Su

> Also, this is a public mailing list, so there is no point in=20
> waiting until
> 23rd of February 2022 to make things public.
>
> Kind regards.
