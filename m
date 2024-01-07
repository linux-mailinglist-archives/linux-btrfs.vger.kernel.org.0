Return-Path: <linux-btrfs+bounces-1289-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 02858826361
	for <lists+linux-btrfs@lfdr.de>; Sun,  7 Jan 2024 09:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 979B3B21D0C
	for <lists+linux-btrfs@lfdr.de>; Sun,  7 Jan 2024 08:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C78D12B6D;
	Sun,  7 Jan 2024 08:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dM8u4mc2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7455F125D3
	for <linux-btrfs@vger.kernel.org>; Sun,  7 Jan 2024 08:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-7cc970f8156so129109241.2
        for <linux-btrfs@vger.kernel.org>; Sun, 07 Jan 2024 00:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704616197; x=1705220997; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zxYo9dnB2OUWaHcJ/MqmBk0pT0P/6+GXQmC1hdnUeOY=;
        b=dM8u4mc2Fmw9ZvyLNy4ADmkUDKaSNaUSOFk+pxfZID56VW0k60eG3MOMAp1pZPYAPr
         lm7t6W4LP5K42c6CzYTuXadwrML/lsecwzZvo+fa4TdtpzwBdYB8bZRW6RCBJeWX4cMd
         X2G/Nppmt666ICRugXpMfO3VXenmPxaOWC0rHtgD9zKukZw5Sh6RJ0iONMG413tQh5Ff
         6vYoNlIPkwoOD9vv6RmNmwgAfO3eT2CRYpQAWpEZ0Kb32k4eRrLOZyFb8jhE4+f8csgX
         woB+UOo1auQzGhwVUgYb81qsOqBzwMEpG11ZL/XuvLH49eLUKNOVj1Vl96WD8DuAPAm0
         wprg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704616197; x=1705220997;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zxYo9dnB2OUWaHcJ/MqmBk0pT0P/6+GXQmC1hdnUeOY=;
        b=oQm6iOS0Sz7Rqtymi9pM3z6atq4YTUUsGzv9ejzder+/3iQ8ZtBYG7Atu0KKWPhqlf
         v9p2yGRsoRVJVQbKtTHqyVd2MSf43Oquu/zoHgstTB3ybkwPEH4oFfGp/0ydwLd6dCHy
         7WK6v67xZ0kQnXWlgB9D/krquanYuThr244ZDMHHAbCg30VSb4F1GC3+v6bdV5d4TMrX
         h1gAdOjl4hjbBtB5tg6dQL6RoFeZPTGyJeLbI49lGZn+LkGHW+SkRh+2EnURchUibVdb
         L6R/a9X3Ld/polJSIESDxzbjpt7u37SFPXbbwLKDOOgXoi1BwDGdaoBpAEmTdXlVEPNX
         aQWQ==
X-Gm-Message-State: AOJu0Ywog1Q44SfvaLH/r3dYJse3hAOaYFBkzNuGYbzLFEooATNS+Vy6
	iza+VSG6FrJCCmlk90jWAeAIeQTVUxczKenl+p0=
X-Google-Smtp-Source: AGHT+IFP/Ve80Xqigp0ComuAze6OhtnCs0MQfZgBFSqa2Mn1wPd6ijHgzyuqysgL49BKxuTbjSGO6wR32dhoriiDLYE=
X-Received: by 2002:a05:6102:4a86:b0:467:c840:67d9 with SMTP id
 hz6-20020a0561024a8600b00467c84067d9mr199343vsb.34.1704616197248; Sun, 07 Jan
 2024 00:29:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFvQSYQvUQXabM4XDNH34y=CsbCHmonmwRh_sS=DkxhJWC2oxA@mail.gmail.com>
 <de1e4749-c265-496b-956d-6ab8e56af7d0@gmail.com> <CAFvQSYReFG3hUJCoRps36hbR1-PaprSsEirodtSS9Bc9nThEtQ@mail.gmail.com>
 <ce6fd895-abdb-468c-9145-655d7755f289@gmail.com>
In-Reply-To: <ce6fd895-abdb-468c-9145-655d7755f289@gmail.com>
From: Clemens Eisserer <linuxhippy@gmail.com>
Date: Sun, 7 Jan 2024 09:29:45 +0100
Message-ID: <CAFvQSYQAocbtWQgaSaa8hrqwDdz+s-Qxa75SsWiOC5ro7EPnuQ@mail.gmail.com>
Subject: Re: Using send/receive to keep two rootfs-partitions in sync fails
 with "ERROR: snapshot: cannot find parent subvolume"
To: Andrei Borzenkov <arvidjaar@gmail.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Andrei,

Sure, the output is:

root@fedora:/home/ce# btrfs sub list -pqRu extern/
ID 291 gen 418 parent 5 top level 5 parent_uuid
1c738933-0bb2-2547-ad5f-326bfc6263b3 received_uuid -  uuid
939c1ed9-9589-6c4b-ace7-2fcdeb970303 path root-rw
ID 292 gen 418 parent 5 top level 5 parent_uuid
939c1ed9-9589-6c4b-ace7-2fcdeb970303 received_uuid - uuid
155f4370-32f0-5f4b-b288-2e8d7302d279 path root-ro

btrfs sub list -pqRu intern/
ID 330 gen 426 parent 5 top level 5 parent_uuid
29fca96e-ca6a-3d4b-b7c9-566f1240d978 received_uuid - uuid
6409bfb7-1af0-7e4b-8a0f-d5a44e34a15c path root-ro
ID 331 gen 426 parent 5 top level 5 parent_uuid
6409bfb7-1af0-7e4b-8a0f-d5a44e34a15c received_uuid -  uuid
258c1fe5-b14e-654b-8ad5-5591268c9095 path root-rw

Thanks, Clemens

