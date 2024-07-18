Return-Path: <linux-btrfs+bounces-6545-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C18F934EE6
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jul 2024 16:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C1A01F2158D
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jul 2024 14:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609751419A1;
	Thu, 18 Jul 2024 14:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jku.at header.i=@jku.at header.b="Idr4Bdgu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from emailsecure.uni-linz.ac.at (emailsecure.uni-linz.ac.at [140.78.3.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD99680BFC
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Jul 2024 14:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=140.78.3.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721311725; cv=pass; b=sTwdj+MePZtAN+nHtWfj341gJk9v0bV54ruFrHwpJu71oJECBSlTqy1JGYxGy6aP7tMxPGjOCEyN1K/4cAjMzXK1F+ZXrePSWbMMgT8sWoXIIlqrGohyyBJT4k+XGi/0OaeW6wGqFVJLXL+9rs5vSUgUhPtS2eOAjgid8eX+H1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721311725; c=relaxed/simple;
	bh=dT+NqHC23bn1xQ7jbffcfC+pckr4mV81djvC0Yv0XQM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gWKp3h1kCj6nwOYHN9hRVA0mQOS5WwdH2pj3t0EDr5ld7Au5sSGJQWjTc14M2I74DkqojhAJj48J/+32ut2nVSqz6D973vqYR5fQ1/wvfTutU6QWMIcFRwst0VFsc2o+iZRXXVdYjZePt1A/pUVg87ccgqY/cQjsWCqKRFTAYT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jku.at; spf=pass smtp.mailfrom=jku.at; dkim=pass (2048-bit key) header.d=jku.at header.i=@jku.at header.b=Idr4Bdgu; arc=pass smtp.client-ip=140.78.3.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jku.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jku.at
Received: from [140.78.146.150] (unknown [140.78.146.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by emailsecure.uni-linz.ac.at (Postfix) with ESMTPSA id 4WPvmS3QfVz4vyr;
	Thu, 18 Jul 2024 16:08:40 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=jku.at; s=202311-arc; t=1721311720; cv=none;
	b=QUJJuNlF9mdR7OmzoFP0go9cxdZFZH4pbiylV6lG0ztUySNnOvtIvAwq21ACZVH2n73BViER+cEQwkGQoYFwJQx6p3jijwgYsOpiYTGUzaC7JgOIFTjsji567OGrbhPeZ92iokcJv6dqd30+lxX8GFa1CaMkjYfEA3dsKMZ2XXa5GWrqVby+QdPnYU6tEScF26uWCX+2qdRmWytZQLEFjgmFZ0lF2t6peb3Jl1L7UuV8TPHhTPKA7GZgm90SSJQWQkbWuyO2sHIxC1b+HowiBTeYdhBBZOu6Ovp04o2l7jaIfvpLFnWkh5GuD/M5PQbQuvOivqvPAHYfXu/bMgr+WA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=jku.at; s=202311-arc;
	t=1721311720; c=relaxed/simple;
	bh=dT+NqHC23bn1xQ7jbffcfC+pckr4mV81djvC0Yv0XQM=;
	h=DKIM-Signature:Message-ID:Subject:From:To:Date:MIME-Version; b=T0dJ3E7o//eboz3pqopCBeFKQgasfu6AmMW6NqJYjlsKkz+OvR7RYy0tICbmBlM6KeAwXp5uDOrkUeUhccqjCUsBp5PWGDO8U95R0n+Xca/+LVtILpRyNQcPrHlC+9T4u2u0qU4FNymmt7EHc0XIB6rfCtawmRYaXcKZpWsALJFqOAQmJMsNpG9Ug8vLkFOVJxHL2cIt74qsKcBcbUQ62JFVFAllFCIjrJoQffEOHvyLcsCzKLx3Xfx30eQ4nGMwwU7ZqgjYR8dYl1YV5X09wcpUHE7USCvjmMuqLmA7d9PlOQpmDr6p81nia4zkdkf3auldj+5sxEAx6PBX3bZiMA==
ARC-Authentication-Results: i=1; emailsecure.uni-linz.ac.at
DKIM-Filter: OpenDKIM Filter v2.11.0 emailsecure.uni-linz.ac.at 4WPvmS3QfVz4vyr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jku.at;
	s=202312-dkim-jkuat; t=1721311720;
	bh=dT+NqHC23bn1xQ7jbffcfC+pckr4mV81djvC0Yv0XQM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Idr4BdguZMuCRhD44wMeC0KD6LPHmS9GrHtatDnEbWnjzqrZhE+UbtxUJhxCF0KoV
	 a1kQNXDDhndBD7Wxovw6ro+V+Vu0oo+1whc9u2MapsRp43z4nImFAK/0An3qe7lOHO
	 2ORMPEUC4WSDOrQbq4ljkigJ0PqJdpy15cbMv1axoeSwuz5dmgwiHnb9j5jXgrN+4g
	 YMfK7MqZPelZvEFDOPAJ7/rFKWGrfSk0FIwA9JL0bWlAXa2gwLXrosqm4NX1e6YUM4
	 D8T8Qwh0FU9gOt64PiGC6v/tpIP5t8JnEBp6IbmF8zaHJVg1rB/cJuLokey+CARk3h
	 dhOREAQPhoB5A==
Message-ID: <9be6318f0b91ed19789a0f58537da897a0602cb0.camel@jku.at>
Subject: Re: Question about 32 bit limitations
From: David Schiller <david.schiller@jku.at>
To: Roman Mamedov <rm@romanrm.net>
Cc: linux-btrfs@vger.kernel.org
Date: Thu, 18 Jul 2024 16:08:40 +0200
In-Reply-To: <20240718185019.74f76e5e@nvm>
References: <4426d5d3202c37b9bc7cea5281c017f77521074b.camel@jku.at>
	 <20240718185019.74f76e5e@nvm>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-07-18 at 18:50 +0500, Roman Mamedov wrote:
> As an option, you can avoid mounting the disks on the box itself, and
> instead export them via NBD, AoE or iSCSI to be mounted on another
> box.

That's actually a good idea. Thank you!
I initially considered block-level network protocols, when I ran out of
memory, but concluded it was easier to just physically move the disks to
the other machine.
Never thought of it as a more permanent solution.

Still hoping that there is some internal debug "magic" to rewrite the
offending logical addresses to be smaller than 2^32.

