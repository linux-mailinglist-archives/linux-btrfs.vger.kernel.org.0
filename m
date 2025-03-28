Return-Path: <linux-btrfs+bounces-12645-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40717A74BB3
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Mar 2025 14:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E0E93BE98D
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Mar 2025 13:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E7E21ADAE;
	Fri, 28 Mar 2025 13:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=jimis@gmx.net header.b="NcMwOslk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4323C1A2C0E
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Mar 2025 13:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743169341; cv=none; b=XkQ6ygspVxl0yYeFr3vcU1tVzx94jIToZh8HuIYJCRpVTFoFfASMWXmHQwSWXI08P81RFOJXETAgpEUVlMDcLAoWMV6CaTKp7yxxJsSmGFbTblDGOCQe4Lkw+SSPYX2Bc+MJMuR6YhC6rD70E8MIEWcaO/REvPt/n31Gw/KTOU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743169341; c=relaxed/simple;
	bh=AV+0qH4BhV+IQVAADKgU8PnwuK9lSeBQdosn8oorVwk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=TIhBvLYaKTxokkT+6lnyoRL/VA95ys/IANuzt4nCutOxVZs2xXHu80sEOYC+vzqDqUThw/ThwmspF7/EsIdYmv9VsZ8na8u1w5XbIyBRtlr5ObuhD1nb1DulCMM4eunAX6LXw5hlFhugZWE7r8R4uujTpekUU2LemXOxhcLSlG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=jimis@gmx.net header.b=NcMwOslk; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1743169271; x=1743774071; i=jimis@gmx.net;
	bh=3VBSJjW5A0r5BhIa+tm/ZLrlgZbXVEa65XWdfxGypWA=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=NcMwOslkGyfjV2iTTb8LCNOf//OhcAzNTJbD73PZ6DaXq04kp1GMIM3E+9XEtEvB
	 y/M7wY8BH3DaXW0I717KuUA8phRa2uTDN0c9RsJRU+uBXdWD/QmKR2SPyDLuIPzBL
	 NQ3dHZqbrTUTWvkXJ1LvSqBDgrFE84KHURCE+xZWxxJ4pYUMQUPzkcay5z+tzA+3S
	 lU5wG1IDJcOhv+TpFqrRvoYHaNR44DxoFPwO076nQumNjBwpwuJMGEyH7iC8WkqA9
	 JvoX4zbjTNP8gx6q31534bm7cr70LyXth27TqiEQWmOC40yEnsfnUY1fEldYwLmr7
	 ImXZTIwx7uAI1dUHvw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.9.70.81] ([185.55.106.54]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Ma20k-1tb6kU3QH6-00Ka6e; Fri, 28
 Mar 2025 14:41:11 +0100
Date: Fri, 28 Mar 2025 14:41:09 +0100 (CET)
From: Dimitrios Apostolou <jimis@gmx.net>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
cc: Gerhard Wiesinger <lists@wiesinger.com>, linux-btrfs@vger.kernel.org
Subject: Re: mount compress=zstd leaves files uncompressed, that used to
 compress well with before
In-Reply-To: <b9f7b83d-5efa-4906-9df3-a27f399162fb@gmx.com>
Message-ID: <d6abe471-8144-3f13-1002-d55cf7d3e672@gmx.net>
References: <2f70d8f3-2a68-1498-a6ce-63a11f3520e3@gmx.net> <d1c2f041-f4f5-9dad-511c-117ed8704565@gmx.net> <8aaba46c-f6d5-4f3a-a029-f564b8a6a9ff@wiesinger.com> <2858a386-0e8c-51a6-0d8a-ace78eced584@gmx.net> <2b33bf94-ec1d-4825-834d-67f4083ea306@gmx.com>
 <ba2a850f-6697-7555-baa4-32bc6bf62f81@gmx.net> <b9f7b83d-5efa-4906-9df3-a27f399162fb@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1931891356-1743169270=:1515035"
X-Provags-ID: V03:K1:0Lwy9k8Uwlxx3TGkpHz5x1GaXOxHGnotYucAd0JXjneEFBTwH42
 n890TkUymtAYFuJkLjoHM3JYxG9pnr4OQlYBYeEjNFF7CJjSzZRX1lf/hqntdTA/po5YdwU
 wO+7Nug+1NEMIF4+9M/HXAN5ZUzjWFqkuQTnE5viwBeiNgMT59s9rA4HQ2WjYKIy6qN/Ge3
 jirpeXHvk8nZUHxuUxl5g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9xS+aX9tGmE=;ZQfQ4AzB8J7sUax1vJ9wJmgCzJ7
 WwjjSQIAiwJVq5BBouU+jGlIxQU+roFCZi8vwqiMh9STaXdIX4YZyS1tqKD6oImcS7RuwyiVr
 +5EFwSgiJ+35BSib7QhwjCwOFz/8Na/6Ywzz7jWJRIDE5bU47PRrZLYhkQKMy62oYGwhDfyB7
 6oMF79cIL9Ge5dCT6mkn5CHqLtfyrAzaIPxBKjOom6Ihm1XsALV7C9rxxVFhFgyhMUxxSBf8g
 HlDenESXyEVVFUKjDW8enRQ9pazr2WPju9/OBPqO2YXJld/nAlYCHVtucWFkYvSGfWjyWMyxL
 h2TThjjFLPPUNvg3IC3EqL0NxrUc1hwCs0aBJ1CS1F+FFysHq72Pdo/fKq7xjxhew/o11tKqC
 2dUTd1mHTc6BNnGa1xf9EXmmFvVHlqSwhTItFR84uvdDZfZB1sP5u86XwmMVaj3UUtPvNtaca
 3Ojd3RW2M0yOqbdxeY9oXHNnViJfgT4smvuGUsUq9UM0QqVLLZ28FkmM1H8qgjkYo45i62KJK
 lSlPD/D35o+dEiDacwEGedn3w+N8v03c+U0qKAjrHwXVQV+n/zgEiAZZOpO/21hU4buFjSTSn
 zxRrEKcL8fuL7q8IcL659hoTIh2eylxzUNRi+PRiwV81uMq+q6eCZYOm9Ajl6kO2BSMtPUiqY
 6awXE9EjCMAondvnER+LX9tRyAGhGGe0DJJ0MPCcWg4RA2tlbQPKI4B/JefH261v+FFz2D4+n
 Yi8yzQGlMIWDQnAWMFg6zpbMV4laK42RLpVDEu/DHjN9VOab/IPXSI0vpUuKW0cqeu6mCestS
 PZktso0e6ESbg8krU/qsnZR22krMIh94mM2CKMmEoUozTKnXytbyBdxLCfkjfa4pLi+v125UO
 rXi+JDsKkAl3bi9HRpZDuZmWcRdB2CFm6XMTiPMP7qNX2shIYZcGkp32dZ5ej8KgsEx+Pq+MY
 inG9zNHn1hqN89QHrNkz9wU1l8rT66Zq5nSiHVfvj2YLpoiq+sQ3zpQzpekHHwS5Xx0d6mLTc
 UvSCCGVGI3vGD7oIy8YrFOi3GK5w/2N0ydt32vOQP/aBdcS9Oz/2lMvI+S/gs1cE6mlxOM0/F
 X/8E/EKbpTZnZxTZ7yXBHbDqFP8NSZuhND5uzvMcUpC6KdYepoboPcbX4Cz+4Hx1Yud4KfDRK
 YJkmwmyTzTeo2CNRvGq/bFw/DzYBSu/zMyQrzRIWlYADKbFbpbY/JAt3CHAhpPu8oU78cuVa3
 Sj0xgDrI26TW2+kTNSPVcDFz1wHCGVRWgvuaM2mMjcw54YLtCnMJo+sCWHmwIiZeIA63n3kL/
 2osfBRcOOu5hKYVAEKul8mzJc9JVLSYr0Ueb8EAB3roNr9LVpVFhjnVZjhRMGDqD22ypw52wN
 nSX3IR/I8h0jW9uuEanKn3cJziJzdEypyT2Q6TXUmxaRl74hUHOthxNt+3SOaKWS+M+DGmLdf
 YcRFgZPjvb1HHd9NDUJ3NqeyhSwI=

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1931891356-1743169270=:1515035
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On Fri, 28 Mar 2025, Qu Wenruo wrote:
>
> =E5=9C=A8 2025/3/28 00:10, Dimitrios Apostolou =E5=86=99=E9=81=93:
>>
>>  Do you know of other cases besides fallocate?
>
> /dev/urandom or something similar, those kind of data will result the
> compressed data to be larger than the original, and btrfs will abort
> compression no matter the mount option.

The docs imply that the compression remains enabled for incompressible
data with compress-force:

   If the first portion of data being compressed is not smaller than the
   original, the compression of the file is disabled -- unless the
   filesystem is mounted with compress-force.

>
> E.g. Ext2 doesn't support fallocate.
>
> But suddenly dropping one feature which we originally support, is a
> little concerning.
>
>>
>>  Maybe the best tradeoff is to add a mount option fallocate=3Doff.
>
> That will be feasible.
>
> I can try push that direction after you have updated the docs.


How about this patch:


diff --git a/Documentation/ch-compression.rst
b/Documentation/ch-compression.rst
index 30b8849c..2553a60c 100644
=2D-- a/Documentation/ch-compression.rst
+++ b/Documentation/ch-compression.rst
@@ -92,18 +92,34 @@ The ZSTD support includes levels -15..15, a subset of =
full range of what ZSTD
  provides. Levels -15..-1 are real-time with worse compression ratio, lev=
els
  1..3 are near real-time with good compression, 4..8 are slower with impr=
oved
  compression and 9..15 try even harder though the resulting size may not =
be
  significantly improved. Higher levels also require more memory and as th=
ey need
  more CPU the system performance is affected.

  Level 0 always maps to the default. The compression level does not affec=
t
  compatibility.

+Exceptions
+----------
+
+Any file that has been extended with the *fallocate* system call (which i=
s
+invoked by *posix_fallocate*) will always be excepted from compression, e=
ven
+if future file growth is without *fallocate*, even if *force-compress* mo=
unt
+option is used.
+
+The reason for this is that a successful *fallocate* call must guarantee =
that
+writing to the allocated range wil not fail because of lack of space. To
+achieve this, btrfs disables COW (thus compression too) for the file.
+
+As a workaround, one can trigger a compressed rewrite for such a file usi=
ng
+the *btrfs defrag* command.
+
+
  Incompressible data
  -------------------

  Files with already compressed data or with data that won't compress well=
 with
  the CPU and memory constraints of the kernel implementations are using a=
 simple
  decision logic. If the first portion of data being compressed is not sma=
ller
  than the original, the compression of the file is disabled -- unless the
  filesystem is mounted with *compress-force*. In that case compression wi=
ll
  always be attempted on the file only to be later discarded. This is not =
optimal




Thank you for your detailed responses!
Dimitris

PS. I would like to add a command that detects if a file is marked as
     fallocate'd. Is there such a thing?


--0-1931891356-1743169270=:1515035--

