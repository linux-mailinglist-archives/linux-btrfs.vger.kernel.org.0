Return-Path: <linux-btrfs+bounces-1290-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5D68263ED
	for <lists+linux-btrfs@lfdr.de>; Sun,  7 Jan 2024 12:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 361941C20BEA
	for <lists+linux-btrfs@lfdr.de>; Sun,  7 Jan 2024 11:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0247312E58;
	Sun,  7 Jan 2024 11:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nBabO6oW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA1712E48
	for <linux-btrfs@vger.kernel.org>; Sun,  7 Jan 2024 11:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-427c4bf6017so11098121cf.0
        for <linux-btrfs@vger.kernel.org>; Sun, 07 Jan 2024 03:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704627756; x=1705232556; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=19yjlrazOte/pDsYnS2e3xqaJwY1EMqzmd+FXu1q6nQ=;
        b=nBabO6oWvLhil4wBO/EzrpXPA9Lq3RLXGSJ3mEZEPO2zN1EJJkAAqTUAVYeLq/7Cum
         BR3evz1nkFl6WC96DZy3HVEmKiHgNHy3Df+JZUze1BL0yh1IjUpUt0DwWSWcixCsaabt
         +XJtDnviyRCXm20K4iW9kQQimKP5ydhBFjPiFeZEIjNnuWYUUaqi5W65spV4C5D7j8sX
         xY3Zes+ohhYvel80PceS+E9fHfUyZ7BrjxoTxEAhKAftB+DtJS6OSeEtitj4OZ5ZwzEx
         RDJjWsQDrq4aVAX0Jep2DompxNyF5oY2pSKXEhfRDyzWnsj8a6ywrdPza8d9m8FFKAtM
         fETQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704627756; x=1705232556;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=19yjlrazOte/pDsYnS2e3xqaJwY1EMqzmd+FXu1q6nQ=;
        b=nwBRKgfVxsmbSchFeMDAHs1zPOeQkyYbB9ZmIpU+RDB6ZNlLtD0SKexuyFxtWl0zzX
         RpdixDgAo9r7a0ifdoKkXtgPPwBFQAR3uV0mAcCFN9K2ftFLS4esDg/atsGfx5aucyLA
         0y/s6G0hrk8GEFOjQ3AlRV/hkVGqUk6g02nNGguQf4W4as7RQqy4ciOn0nR5qX/zojoJ
         qbfOD+Z+U2IGhHLVumK7ZqWrE78iHOVLUOUqxRpCx0RcpD7ji1gjGIUXBwQdVclbLZHU
         PJ8Qum9Kb+Qa1MY2TfElI0SnCwcraKvxxV6d4z+M/cZ8lBIQ5WMunxWOCW1U/8emsc0g
         ugAQ==
X-Gm-Message-State: AOJu0YzmOlx/7F4cBh5mnlNR0q5etMVOR0v6t4ew+qB4aCPJm5Xs+zCk
	0wJDC9xCTOrOOEl8J97aUQy4X5fsMNXsxEFdxLQ3FuWmepE=
X-Google-Smtp-Source: AGHT+IGb1SVkDWbgQPHbvqiLUQvpbwXNdO44MtQZn9K/dJDYOgVFFXBtVLFiSzCIEpen+QQTSS7zRcXjBLCbWFYb/3w=
X-Received: by 2002:ac8:5805:0:b0:429:78ba:337f with SMTP id
 g5-20020ac85805000000b0042978ba337fmr2496714qtg.81.1704627755214; Sun, 07 Jan
 2024 03:42:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFvQSYQvUQXabM4XDNH34y=CsbCHmonmwRh_sS=DkxhJWC2oxA@mail.gmail.com>
 <de1e4749-c265-496b-956d-6ab8e56af7d0@gmail.com> <CAFvQSYReFG3hUJCoRps36hbR1-PaprSsEirodtSS9Bc9nThEtQ@mail.gmail.com>
 <ce6fd895-abdb-468c-9145-655d7755f289@gmail.com> <CAFvQSYQAocbtWQgaSaa8hrqwDdz+s-Qxa75SsWiOC5ro7EPnuQ@mail.gmail.com>
In-Reply-To: <CAFvQSYQAocbtWQgaSaa8hrqwDdz+s-Qxa75SsWiOC5ro7EPnuQ@mail.gmail.com>
From: Clemens Eisserer <linuxhippy@gmail.com>
Date: Sun, 7 Jan 2024 12:42:23 +0100
Message-ID: <CAFvQSYQO07n0n4-A=fXix3T6Pqu4mtT2YiY+UVVV3c=+kUMReQ@mail.gmail.com>
Subject: Re: Using send/receive to keep two rootfs-partitions in sync fails
 with "ERROR: snapshot: cannot find parent subvolume"
To: Andrei Borzenkov <arvidjaar@gmail.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi again,

I've reproduced it now a few times and still can't draw any
conclusions from the observed behaviour.
I can modify the rw-snapshots manually or even chroot into them,
install packages via dnf etc and everything works as expected, the
sync scripts run through without any issues a dozen times - so my
guess is the scripts actually do what they are supposed to.

However once I've used a rw-snapshot once or twice(?) as "real" rootfs
(not chroot) everything falls apart later when executing the scripts
with "ERROR: snapshot: cannot find parent subvolume".

Could it be that fedora (the distribution contained in the subvolumes
) as part of its boot process somehow modifies the subvolume or
performs operations within the subvolume which disturb a offline
send/receive performed later? As far as I know I am not using software
which explicitly uses btrfs-fetures like snapper - the only thing I
could think of is podman (running with unchanged default config).

Thanks & best regards, Clemens

