Return-Path: <linux-btrfs+bounces-10049-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F17239E322C
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Dec 2024 04:35:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F31C6B25B26
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Dec 2024 03:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A497D51C4A;
	Wed,  4 Dec 2024 03:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=scoopta.email header.i=@scoopta.email header.b="Yt4Lh200"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx.scoopta.email (mx.scoopta.email [66.228.58.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718F524B26
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Dec 2024 03:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.228.58.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733283290; cv=none; b=mDaHJJ5Z8Ztx2yVi6B3mmJ+C9fU2iJZ5ZzV0vUkrGCWieR2uUyvA9/Gakqf5i+PcpSBfsBNcYXIy363c3m9J3h3r71BR/cSDjzNX8VxfDgj8w70TvFYN8kxnXpFTTzG10x4PCqdV22oDLy7pfmwd8kG1xFLpv0FQf4bMYJ1+hzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733283290; c=relaxed/simple;
	bh=54suXVxUiXrXZcd94iBC66C7tYb882O1XlaesIwyP3M=;
	h=MIME-Version:Message-ID:Date:To:From:Subject:Content-Type; b=gnnfbEvtERrAqmY418+ncFNK9AvJyvzJmK4AHtv/Kqt8LWpEiMvoQXwYCG1yogvJTA3qjdK319vt18PsKI9ijLIffHKeiMLkdF/k7BnvGJDzNLlnWl+xrS+G16p1REwuW6s24+2ICRJHFbc6hBf154rByMiaTyz8Vs9MLl0qKRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=scoopta.email; spf=pass smtp.mailfrom=scoopta.email; dkim=permerror (0-bit key) header.d=scoopta.email header.i=@scoopta.email header.b=Yt4Lh200; arc=none smtp.client-ip=66.228.58.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=scoopta.email
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scoopta.email
DKIM-Signature: a=rsa-sha256; b=Yt4Lh200i+hQPCe3f+WI65b0T2xIkvEv5Kj88m4nvI+3PVZccnxwQ9KFt8WZNFJYUbczCowEa1QB5qOydO/XFf9psCGK+OF0PU78onietYaI5YSi6WLJQ5fUNEW+hRMivCmZpIf85VzAENXufgwTEAlIhiWOHI4h3soKIPsHDGjR6B+JbZ1cLjXOA3ONtxyWEchu5RndV2Q8ojyu3GFT6DFiPcwEM+gdQhGCVviGzaYxIVXX+kI0izkL2qAEAHUNwBKJQq5LBy1RCTGHc88+qlDDpi0hM9jfqfGoXvulTPYeBoF3LcxVI8Nb6ZOIitjKmfPF4vG4eMAp2g4hYjSUqRCOqQDZE/tiQdGqsZ52IpRWjc0mFICXQF6Ct0Z0KU8htAcZZt28+/+cNAmQLc4ZvwRLZHHqnEEmSyDIwtkQkntDQwQmchqmmkgHU26y6v/BJUk47aY7056nYR7ZtpYJXOaydzO/79rVPvX4hwF9DBYkL3sK7KO7/1c2rjGgLiJ9YvpnSip87ko1q87ZtOim78yj9PQZyLXNRqseeKykOwZ89YSP6IBPU1SAGaNfJIVPRYfFVhH75OomgOolFbMViXCgI9HWvZgYXkg6XuR+rISqbORDzbJaC1Ue06u6Up1pTia7JzwChSoTnzbXv/KaKnWfyLw0FZ6o9BFiQFTba2u1lajjotpcaMgFRB3uqD4yb1WQUHi8WHiior/ronndwiDeIFkkJ0F/R1CKUJG4o8zElGMGSNPvbtYk7duqvrFYVK05mHwQj+3mdAXysCf9zid5wVoDjnpyMXHz5EisczdmvrJ5Sr/HMFl1g80auajdlFMwbHiLJrFUaPF8Xg6BqwR6MluUqfVvVVc027iiS/DO+4NAiuicCsZajy7zv7XDrfcdn5DBYsj2DaZviSNhsqrZIwzo+9tAHknDc6FHcyMHP/hpQnZLiKGK/QDqL9d2iTqrOL
 IsvcbBBgsoZVUOHkPL5egLL+4ifCdXwzl/LzqzzSxr6JimlvoEK93z/q9MN+4xE98g2Z7d81LtaGvF86FxAG79JJRaV++S5bpt67XZ30MqCfdvdX9A1J7yn8xicQEowOb5PLOqbHPpG2/CObar+AmFjQRVKmezakjE9mNgGyybeF7rB7ZaihdDgAq46LvUiMfV7YqJ9d0lYKnbAV4EFtkIUUqicnVT7DuHtEGuddcMjAvmSrn1H63O6x5HB6dICr746v1sRkalrvsfKxcZIcm6twZ18CEERjIfGOq2GGVKSWU7S03ZeczAQ43lMjW0YSBySdWqSu8aNGq11Qk4PTyaTQzAO1aWmvAyHCx22GrSwBwkopkxr4GumiBh4zvI0KL4dlEgMpFie1RTnw==; s=20190906; c=relaxed/relaxed; d=scoopta.email; v=1; bh=wivXW1w0IvCZz9Hp53YkXlWafXrrmCBsEU2xv5InrVw=; h=Message-ID:Date:Subject:From:To:MIME-Version:Content-Type;
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-UserIsAuth: true
Received: from me.scoopta.ninja (EHLO [IPV6:2602:2e1:80:111::f0c5:cafe]) ([2602:2e1:80:111:0:0:f0c5:cafe])
          by scoopta.email (JAMES SMTP Server ) with ESMTPA ID 1706130901
          for <linux-btrfs@vger.kernel.org>;
          Tue, 03 Dec 2024 19:34:26 -0800 (PST)
Message-ID: <97b4f930-e1bd-43d0-ad00-d201119df33c@scoopta.email>
Date: Tue, 3 Dec 2024 19:34:25 -0800
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-btrfs@vger.kernel.org
From: Scoopta <mlist@scoopta.email>
Subject: Using btrfs raid5/6
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I'm looking to deploy btfs raid5/6 and have read some of the previous 
posts here about doing so "successfully." I want to make sure I 
understand the limitations correctly. I'm looking to replace an md+ext4 
setup. The data on these drives is replaceable but obviously ideally I 
don't want to have to replace it.

1) use space_cache=v2

2) don't use raid5/6 for metadata

3) run scrubs 1 drive at a time

4) don't expect to use the system in degraded mode

5) there are times where raid5 will make corruption permanent instead of 
fixing it - does this matter? As I understand it md+ext4 can't detect or 
fix corruption either so it's not a loss

6) the write hole exists - As I understand it md has that same problem 
anyway

Are there any other ways I could lose my data? Again the data IS 
replaceable, I'm just trying to understand if there are any major 
advantages to using md+btrfs or md+ext4 over btrfs raid5 if I don't care 
about downtime during degraded mode. Additionally the posts I'm looking 
at are from 2020, has any of the above changed since then?

Thanks!


