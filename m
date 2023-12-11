Return-Path: <linux-btrfs+bounces-823-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FAF880DE42
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Dec 2023 23:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 386C7B21308
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Dec 2023 22:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074774CB2B;
	Mon, 11 Dec 2023 22:30:20 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B262E4
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Dec 2023 14:30:10 -0800 (PST)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 71D0536316B;
	Mon, 11 Dec 2023 22:24:02 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id 27D9B3631D5;
	Mon, 11 Dec 2023 22:24:01 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1702333441; a=rsa-sha256;
	cv=none;
	b=jXx4jYE58LmuYAeyTW/cp1GdExl9Zs7A9QCXIB27sE9B34YQHLHUjnQ8EPKCPvsQcC+3xn
	jqfvW788/ZRupOH/2Bjzi6qsi/QBxoajDQSVrcZXOVVphkvaZVvTNsI91kePcMdPx+PcHV
	nO/VxhMp+P+ovUGyaaYegMP5vwibqLqs61FNadEPf79x9IucYs8x99k+CA2pEUYtYhRaOH
	KlEYDJBArqwEP0b94pTI1SMKJcgHkkzn4eAw83IyD5AKSwhMS8CTFZ2vLevX5XC7+bWaIm
	HLOzy9/xANhO2JDkb1pUflypz2UZ/6LtBlpEdqAjgazKovHQNEX8bVa45bKK2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1702333441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oSMruv8vHCgWUJmEpAriWG+zMh4jhx28++2IRpo9Lb4=;
	b=5Lb3E3JM7xnUwTwxOuOpbEqSRMoy2cpJH1jwDMwQ1wOFKMeDURTzt6/ZQUrxgRubwB9QcH
	7POgjCvGr8V9YDj0f7sbk7Aj6Bn2k4FC25Im4xXTETfUVjvmOjdPpmaUF4dO/hecIBRxLX
	q0eJP+ejinAOb5q5D3DkEtXjkklDeMVT1aAyrPRS2XbIcxkDsJBmdaqhrAsw5KpLMsPjnZ
	686hwGFqhXilk8yxRTyYmUpOi6oKdyp7tWdWl7lqN7mu59RVaWyIgrM535L1Hd9EX7Kxu+
	qUB9hrDCXY0VaFpgziEoIvUDsh/qDxWjgWX9ORaRyJujRVv5EJ9Hnz0ZsD3cAg==
ARC-Authentication-Results: i=1;
	rspamd-5749745b69-kk6rb;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Bubble-Stretch: 14f6bedb628f1ea8_1702333441687_1733466020
X-MC-Loop-Signature: 1702333441687:2709048962
X-MC-Ingress-Time: 1702333441687
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
	by 100.124.185.79 (trex/6.9.2);
	Mon, 11 Dec 2023 22:24:01 +0000
Received: from p5090f0e4.dip0.t-ipconnect.de ([80.144.240.228]:39262 helo=heisenberg.fritz.box)
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <calestyo@scientia.org>)
	id 1rCogt-000660-2M;
	Mon, 11 Dec 2023 22:23:59 +0000
Message-ID: <95692519c19990e9993d5a93985aab854289632a.camel@scientia.org>
Subject: Re: btrfs thinks fs is full, though 11GB should be still free
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Date: Mon, 11 Dec 2023 23:23:53 +0100
In-Reply-To: <253c6b4e-2b33-4892-8d6f-c0f783732cb6@gmx.com>
References: <0f4a5a08fe9c4a6fe1bfcb0785691a7532abb958.camel@scientia.org>
	 <253c6b4e-2b33-4892-8d6f-c0f783732cb6@gmx.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2-1 
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-AuthUser: calestyo@scientia.org

Hey Qu

On Tue, 2023-12-12 at 07:27 +1030, Qu Wenruo wrote:
> Is your current mounted subvolume the fs tree? Or already the data
> subvolume?

Well actually both, I always have a "service" mountpoint of the root
volume as well, and just unmounted that to no confuse with "double"
mount entries.

In reality it looks like:
# mount | grep vdb
/dev/vdb on /data/main type btrfs (rw,noatime,space_cache=3Dv2,subvolid=3D2=
57,subvol=3D/data)
/dev/vdb on /data/btrfs-top-level-subvolumes/data-main type btrfs (rw,noati=
me,space_cache=3Dv2,subvolid=3D5,subvol=3D/)

But all data (except for 2 empty dirs, where on other systems I would
place btrbk snapshots) is in the data subvolume:

data/btrfs-top-level-subvolumes/data-main# ls -al
total 16
drwxr-xr-x 1 root root 26 Feb 21  2023 .
drwxr-xr-x 1 root root 30 Nov  9 23:49 ..
drwxr-xr-x 1 root root 20 Feb 21  2023 data
drwx------ 1 root root 10 Feb 21  2023 snapshots
/data/btrfs-top-level-subvolumes/data-main# du --apparent-size --total -s -=
-si *
29G	data
10	snapshots
29G	total


> If the latter case, there are some files you can not access from your
> current mount point.

No it's not that (that would have been quite embarrassing ^^).
/data/btrfs-top-level-subvolumes/data-main# tree -a snapshots/
snapshots/
=E2=94=94=E2=94=80=E2=94=80 btrbk

2 directories, 0 files


> Thus it's recommended to use qgroup to show a correct full view of
> the
> used space by each subvolume.

Uhm... qgroups? How would they help me here?

Cheers,
Chris.

