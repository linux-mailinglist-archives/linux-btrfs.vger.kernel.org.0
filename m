Return-Path: <linux-btrfs+bounces-5729-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A8590807C
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Jun 2024 03:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7686C1C21333
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Jun 2024 01:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F59158D8C;
	Fri, 14 Jun 2024 01:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="r/6Y6Ge6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A2F158D84
	for <linux-btrfs@vger.kernel.org>; Fri, 14 Jun 2024 01:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718327231; cv=none; b=dWBTxDMI3GDAgUknXaqGbBeykrjGzBC4XlbkrXy8JkJP2AmIdEoIUc5TyYz/ttOXziR7fsl6kYBqfbe1F1VvrwdHEZX5Ww5FlgGoGGmA4VQ9CeVcZrKZWYQ2918sHtT4RhjxrMQS91QJww5aYo1775Mpd3+YNDdho0kbUVBa/6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718327231; c=relaxed/simple;
	bh=yyOMDzfiT+aGiH02fs2tunSyr54TiRYmBb1PdBN2AVY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZowAPeIsNQSQlV172UwfRc+M0C1dQrMFuXhCKyHBvjudMlIEhUpT/kJC6cl9c+nNeqJmR/apkmb++9fWS6pt23YLlmNxPOPiOAXQM7w0rXso+ZbzY+1VJ6C3MpSboEGx2d2FDYHukE/mnUoJW8GtW7KyHIJYSRvoFH41FDcXxCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=r/6Y6Ge6; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 8B7B0240103
	for <linux-btrfs@vger.kernel.org>; Fri, 14 Jun 2024 03:07:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1718327226; bh=yyOMDzfiT+aGiH02fs2tunSyr54TiRYmBb1PdBN2AVY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:From;
	b=r/6Y6Ge6p6Yo6exZwvIR30ltR3eZ5/sTp++71AQxhQh2Sp1Gz73W7UO/Yuo9QMqCJ
	 9DQ4mRT5GFc3f4T1Xc6wy+ti5NdavcOXlGBwK8dykeG+yfG30bE1ud7uvCEO0Qqh5x
	 MNW3cDbXdnXfIyLGdEo9ZBVGBcaNo5J4Z0TQNANl0V1DpxDnoHwiuCsowLrYFzZPLP
	 ze3Fj31zCZum7cn9ygcwbgj3wv75YivA6RHsJgOaM8ESKZF+IZdxCW5fbpmXWYrfce
	 Lp48jo6iMNjFM+6oVSSK54io1bMweWR6zPuQgW7Ixpzk+Cay05cnpmXJ8//SJo1hZr
	 QJ0wRXarBYCBw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4W0h1z09jTz9rxF;
	Fri, 14 Jun 2024 03:06:46 +0200 (CEST)
From: Nicholas Hubbard <nicholashubbard@posteo.net>
To: Jddgreen4 <jddgreen4@gmail.com>, linux-btrfs@vger.kernel.org,
 majordomo@lists.pm.org, majordomo@netbsd.org, majordomo@slackware.com,
 majordomo@vger.kernel.org, maris.hubbard@gmail.com, mcuban@gmail.com,
 mesparza@tmhcc.com, mgambrell@gmail.com, modules@perl.org,
 neilb@neilb.org, nhub73@keemail.me, nichlashubbard@posteo.net,
 nicholashubbard@posteo.net, noc@metacpan.org, oce_admissions@uml.edu,
 oglesbeeb@nextcapital.com, oliver.odonnell@storm5.com,
 overseers@sourceware.org, perl5-porters-subscribe@perl.org,
 perl5-porters-unsubscribe@perl.org, pete@perl.careers,
 pherrera@envasetechnologies.com, phil@philkasiecki.com, pmaggio@wcpss.net,
 resources@fsf.org, sandeep.kashyap@flextrade.com,
 sandeep@flextrade.recruitee.com, security@gentoo.org,
 sfredenburg@usherwood.com, shane.tomlinson@motionrecruitment.com,
 shuyu_lin@student.uml.edu, simon.peytonjones@gmail.com,
 steffan.haeberle@gmail.com, submit@bugs.debian.org,
 subscribe@lists.gentoo.org, subscribe@vger.kernel.org,
 takelley@email.unc.edu, team@perl.careers, teapartycinema@gmail.com,
 techjobs@meetmax.com, thibault.duponchelle@gmail.com, transfer@ecu.edu,
 unsubscribe@lists.gentoo.org, unsubscribe@vger.kernel.org,
 valerieaferris@gmail.com, warlockstattoo13@gmail.com, whubbard@tmhcc.com
Subject: Disregard Previous Email
Date: Fri, 14 Jun 2024 01:05:01 +0000
Message-ID: <87sexg49hp.fsf@slackasus.slackasus>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hey, my email was hacked and they sent an email from me containing "I=E2=80=
=99m sorry for bothering you, I=E2=80=99m in a tight spot, do you order onl=
ine from A m a z n often?".

Please disregard this. Fortunately I was able to regain my account :).
--
Nicholas Hubbard

