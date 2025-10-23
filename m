Return-Path: <linux-btrfs+bounces-18219-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E629C02DC3
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Oct 2025 20:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0A7CD35994E
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Oct 2025 18:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F9F34B423;
	Thu, 23 Oct 2025 18:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="BOwYgAKh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81D334B1B1;
	Thu, 23 Oct 2025 18:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761243052; cv=none; b=UmyJ8YuynT99fUP4LoTiScQZg85GPSU7i+51JdoSaoXX+j64FPqLQ35HeZTWwZIrCSnKPQQbmYoJtFD4Kp7HzAE6LDZ6iW3uCOwShS1AABmI6N+raHRt5Alshxv0zmF3UPlZJEg4DD3COQg2O79JeK1xkR8ZU4QMarTowqDIzms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761243052; c=relaxed/simple;
	bh=WE0GiHXM5wLFmCst3tPXj2iOCj0/6Z0FGnXt6b0lhOU=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=lA532lzE0Aai3EatrhkXCNIihu3neqNsAyjyXDAT8fukj4w+6cntnFmvztQ7GHQb12aR6SP9ug4y5ORNIg34QMVfmjxeDDEevAaG8AizKnLlbinU5jQjNb8iFzNp+uvGNLHd3lEpVqgN3Vqig41RKSFrC5QGDy9NhDCJcC7U3EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=BOwYgAKh; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1761243041; x=1761847841; i=markus.elfring@web.de;
	bh=WE0GiHXM5wLFmCst3tPXj2iOCj0/6Z0FGnXt6b0lhOU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=BOwYgAKhOley1PV3j0qy7cRMJ2bZUgmpYIBi2lx9TcXbnW/1MC8/6BfQ0bdG9DaG
	 JOj5DnBb0sfedxf5fMvkzUFH7EFFex6epZU5YZ7+GQzVKMlb4d3zKKeKxKi/LUYN+
	 wxZkE7y16eZmoizyjwKMf4yWl5ubqxJOLNqOrBK8v+H2be6UnyJ5rCFAxJ5sqEqdJ
	 ooRtVpiz137KQztj60glMr/6S8po8KMiwqHegizPDrHXwXv56xbVUZWqn/1BDJv2S
	 AQiPgHjtChLWNo46DMQQGXq06jH4AaCKjcmGZYo0TuOlNd78c3W+GiNs444kIe47m
	 /URXtke+HMTNEWYdjQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.227]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N8Elm-1u83Cz2ooS-00wXV7; Thu, 23
 Oct 2025 20:10:41 +0200
Message-ID: <0fd665d6-a8a7-4cd4-82ca-05cf770f88d2@web.de>
Date: Thu, 23 Oct 2025 20:10:40 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Ting-Chang Hou <tchou@synology.com>
Cc: linux-btrfs@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Filipe Manana <fdmanana@kernel.org>
References: <20251016075351.3369720-1-tchou@synology.com>
Subject: Re: [PATCH] btrfs: send: don't send rmdir for same target multiple
 times with multi hardlink situation
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20251016075351.3369720-1-tchou@synology.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fM4HIfAc0j5MP+T7Jv2TYOtmE040MO017IGdLE1Yb+uHV/eIZ4T
 CIx5fEANdctX8dDEPk0YgUMoj9xJWaAI/JNDsw5MIf0quQlUV4+UuRbIYhpAMnsUl8vHELx
 0z/2jMx3uj4br82xaNWufV00q++OwD0DWdVtKpnKibfgKn7OHIxYLyxNu6UyuRwqPNEH2om
 +UVM71+fcoJIZkPgdmmuQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:CbM6flarBho=;8VmTUhj3omYr8Rfso6MmDobEsv+
 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
 0wuOg==

=E2=80=A6
> Disclaimer: The contents of this e-mail message and any attachments are =
confidential and are intended solely for addressee.

See also once more:
https://subspace.kernel.org/etiquette.html#do-not-include-confidentiality-=
disclaimers


=E2=80=A6
> If you have received this transmission in error, any use, reproduction o=
r dissemination of this transmission is strictly prohibited. If you are no=
t the intended recipient, please immediately notify the sender by reply e-=
mail or phone and delete this message and its attachments, if any.

Do you expect this action to happen more often with your information?

Regards,
Markus

