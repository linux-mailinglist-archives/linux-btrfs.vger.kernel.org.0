Return-Path: <linux-btrfs+bounces-6854-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB9F1940078
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jul 2024 23:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7244A2838DB
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jul 2024 21:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B333818A93C;
	Mon, 29 Jul 2024 21:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OhKKYpts"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4867D3F1
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Jul 2024 21:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722288667; cv=none; b=oQgtKbPRIbOve4Qxks0KlC50WiQ2N095s9Wr0wTIa7piVJ5daUMg4jXr0Gdx/MzyYAKqXNPTCMDgwIou/v9ih7Xw/8ia7TQ0gEQQFyoBpAe0YaUL0DnXQkHeZ6cqiUsHQ/yMDBjDppONCPa3lIOPWv8C6qobLgWO6BgaAlh4lC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722288667; c=relaxed/simple;
	bh=nm7O0ppKX9Cia1gJErnaR8vfjz7KkorUJKy+tg6/wH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pSZUJYiTlRtdAWun+DRqioqVs1RBwISInr/qZriyoStyifK6RSZqZiNdrbtaVsdDWZBge0JrAN8luXhHtoYtLgtVYAgJ9Mb75gnC9/Z7VLzai3poAo2BvkmeBtJSjKYZ8BNpKgz/5l2dSX0loTzhF1jUPkuKL3yGNybxsTBCQo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OhKKYpts; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2f035ae0fd1so47828591fa.2
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Jul 2024 14:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1722288663; x=1722893463; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KK1MHG8V+elH5uJjk6MCBdN/4Bopbo5ZlMkdOW0rdW8=;
        b=OhKKYptsLJfoo7N+Jjdyn2Z0Y6U+nX4Q9REAajcjPHj630iA72evK2Zx5FTj3GlraY
         VqhnyKGxKX+NlrI9u85LkZBQ9use9VA8GFwt/omk4UhtgpAUSkHCkOUkgNrsd/i2t5iY
         heN3HCJVu8RwCJ7+Oh3mtciC/rurNkNIzA43+bZG/QWWqYvld8wBvpP/gUd57hxm/9NT
         tRi9/KwI34QuHkUDfqquIPmyyVti1BGOxDpT6MN5aHkM3kG0PS1xyyROGf3+xAqXO8z3
         CgwQubUeGj5ls0xAKAOJ8g3J1BjKViKPzqPF5c9zZTSmLfrwvw6VSwTbMnjKEU2bAc+z
         jikA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722288663; x=1722893463;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KK1MHG8V+elH5uJjk6MCBdN/4Bopbo5ZlMkdOW0rdW8=;
        b=oQTG7J57lsoLJ/NrvTe1Bm/NBA/c+RcDDPbcY7bdXLYq6PX0a1wuDc1SMT10emvczJ
         4MVKUkHVnMCE71pLm1XwK0ov1CNqgtDWC4oLb7r0nmk8BHse4Dr6LPDir8Dbizo4bmg2
         MqtrHR3gflaHqngVDTHCwmKbrUIlhHXQrAFU1qx4MAGsctNLtwHyRPBSQZLRpLYq/D+n
         CnVzW1BETGHMP4BRkq97Zd/Byy919yro70ro9RbCZfwbp3ofZRL2qQlRUCtdEXqcCG5W
         hCsWjVC19ytGhlPy0ULYFbHS2Lv1WsLzPt55cPDCfLs3vIwd+vLT/oqV+QgqacbzHtFU
         2Tww==
X-Forwarded-Encrypted: i=1; AJvYcCWfYUUq9WcsyLz9LCo/Qwj2ptGN9bxk3tvot8cZufRA4QwtzKSSWHO0N25zferxKpe99xD7kn4KwrdeqXEOHPtRPPH9XyxltZ3WXqY=
X-Gm-Message-State: AOJu0YzBIB5T1bysnFfrwZbn7sxc5PQPs55Ai1/UDH/1HSMjovZHbyl/
	hTtFz50dvYQkxunQOPqSGpoyRX3mtrcyLxa5GiPsWJmtE33FaxeWYDJkCr+4R2hCk9Yowqc37Kz
	2
X-Google-Smtp-Source: AGHT+IFniCbEqYLexse84Q5Yv450kspa47xPl4p3f/7j6LeoCMeK6wpadZfSfAs4uaB8VpVmT6ZuVQ==
X-Received: by 2002:a05:651c:204:b0:2ec:89b8:3d2f with SMTP id 38308e7fff4ca-2f12ee17880mr60070721fa.19.1722288662746;
        Mon, 29 Jul 2024 14:31:02 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7ee115dsm87806255ad.143.2024.07.29.14.31.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jul 2024 14:31:01 -0700 (PDT)
Message-ID: <2ab71fbf-6366-4407-a74d-3f172c488d67@suse.com>
Date: Tue, 30 Jul 2024 07:00:57 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Virtualbox and btrfs superblock issue
To: =?UTF-8?B?SsOpcsO0bWUgQmFyZG90?= <bardot.jerome@gmail.com>,
 linux-btrfs@vger.kernel.org
References: <CAK6hYTsFwBVXAJ3yBkBX-3tgmAj=1OFxN=2kybiovxjtTX4yOQ@mail.gmail.com>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJVBQkNOgemAAoJEMI9kfOh
 Jf6oapEH/3r/xcalNXMvyRODoprkDraOPbCnULLPNwwp4wLP0/nKXvAlhvRbDpyx1+Ht/3gW
 p+Klw+S9zBQemxu+6v5nX8zny8l7Q6nAM5InkLaD7U5OLRgJ0O1MNr/UTODIEVx3uzD2X6MR
 ECMigQxu9c3XKSELXVjTJYgRrEo8o2qb7xoInk4mlleji2rRrqBh1rS0pEexImWphJi+Xgp3
 dxRGHsNGEbJ5+9yK9Nc5r67EYG4bwm+06yVT8aQS58ZI22C/UeJpPwcsYrdABcisd7dddj4Q
 RhWiO4Iy5MTGUD7PdfIkQ40iRcQzVEL1BeidP8v8C4LVGmk4vD1wF6xTjQRKfXHOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJuBQkNOge/AAoJEMI9kfOhJf6o
 rq8H/3LJmWxL6KO2y/BgOMYDZaFWE3TtdrlIEG8YIDJzIYbNIyQ4lw61RR+0P4APKstsu5VJ
 9E3WR7vfxSiOmHCRIWPi32xwbkD5TwaA5m2uVg6xjb5wbdHm+OhdSBcw/fsg19aHQpsmh1/Q
 bjzGi56yfTxxt9R2WmFIxe6MIDzLlNw3JG42/ark2LOXywqFRnOHgFqxygoMKEG7OcGy5wJM
 AavA+Abj+6XoedYTwOKkwq+RX2hvXElLZbhYlE+npB1WsFYn1wJ22lHoZsuJCLba5lehI+//
 ShSsZT5Tlfgi92e9P7y+I/OzMvnBezAll+p/Ly2YczznKM5tV0gboCWeusM=
In-Reply-To: <CAK6hYTsFwBVXAJ3yBkBX-3tgmAj=1OFxN=2kybiovxjtTX4yOQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/7/29 23:32, Jérôme Bardot 写道:
> Hi,
> 
> Sorry if I post at the wrong place but  I didn't find an issue manager
> (like gitlab).
> (I also asking myself if a not already post but maybe before i subscribe)
> 
> So my issue :
> 
> On a windows host laptop and with a parrot vm with a btrfs and after a
> power failure the vm looks broken.

IIRC VBox default to ignore flush/fua to improve performance, at the 
cost of protection against power loss.

https://forums.virtualbox.org/viewtopic.php?t=13661

Although traditional journal based filesystems are also affected by this 
bad behavior, btrfs is especially sensitive to bad flush/fua behavior.

> At start the vm drop down to initramfs.
> When I try to mount from an iso (of the same os/version) i get following error :
> 
> mount -t btrfs /dev/sdc1 /media/user/to-rescue
> mount: /media/user/to-rescue: can't read superblock on /dev/sdc1.
>         dmesg(1) may have more information after failed mount system call.
> 
> and dmesg get following :
> [71283.615636] BTRFS: device fsid 70bf0953-3ee3-481f-8a7d-f7327c6fba67
> devid 1 transid 182616 /dev/sdc1 (8:33) scanned by mount (24156)
> [71283.627681] BTRFS info (device sdc1): first mount of filesystem
> 70bf0953-3ee3-481f-8a7d-f7327c6fba67
> [71283.627711] BTRFS info (device sdc1): using crc32c (crc32c-intel)
> checksum algorithm
> [71283.627725] BTRFS info (device sdc1): using free-space-tree
> [71283.639345] BTRFS error (device sdc1): parent transid verify failed
> on logical 26984693760 mirror 1 wanted 182616 found 182618
> [71283.642087] BTRFS error (device sdc1): parent transid verify failed
> on logical 26984693760 mirror 2 wanted 182616 found 182618
> [71283.645163] BTRFS warning (device sdc1): couldn't read tree root
> [71283.646224] BTRFS error (device sdc1): open_ctree failed
> 
> How can (if I can) I fix that kind of issue.
> (i did not create backup/btrfs snapshot)
> I get that issue on 2 similar setup / power failure and one with a xfs
> system too.
> 
> I'm really newbie with btrfs.

Transid mismatch is already a death sentence, not to mention it's 
corruption on root tree (the tree for all other trees).

It's really better to just restore from the backup, and go some more 
sane VMM tools other than VBox.

Thanks,
Qu

> 
> thx for your feedback.
> 

