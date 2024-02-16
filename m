Return-Path: <linux-btrfs+bounces-2455-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE11857E8C
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Feb 2024 15:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F26A9B22969
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Feb 2024 14:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E831E12C550;
	Fri, 16 Feb 2024 14:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=inix.me header.i=@inix.me header.b="HHB2+VW8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.inix.me (mail.inix.me [93.93.135.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF0612A17B
	for <linux-btrfs@vger.kernel.org>; Fri, 16 Feb 2024 14:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.135.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708092272; cv=none; b=Ug+XEUeiHbdp/IDodWbmJwln2codckyoSXQNRu/NwlmYip8wQ6YWP0Ux/2jrV62o9SI3GsTSu+tNMpe3mfoZV4bt5GBVPPz1/nPlsP9C/hJv10nMkv97Sg8LfjI/orBdRmlXdRHq9TZYZ7H8LclnPBpBBbokdoeGVYJ8uO5+jmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708092272; c=relaxed/simple;
	bh=sbof/qLn+dOQrA0pLRhhBfo0WnNOpglgyymvixy8y80=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=RiQSnZq0C2W4kgtMbTXfWIlHqQWNN4o0Etb0cjeZJ//18Ru2/LwHkCnW4Z31LDqc/kBM7C4yjzdXYyykgkambsfqko97S68lpCjT4Dfj75E41jwpDnhdAByH8M/xt5e4YrSNWHNruUVQ2Kwg4iKFmqizHfJoomZs06QKEboobns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=inix.me; spf=pass smtp.mailfrom=inix.me; dkim=pass (1024-bit key) header.d=inix.me header.i=@inix.me header.b=HHB2+VW8; arc=none smtp.client-ip=93.93.135.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=inix.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inix.me
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inix.me;
	s=primary; h=Sender:Content-Transfer-Encoding:Content-Type:In-Reply-To:
	References:Cc:To:From:Subject:MIME-Version:Date:Message-ID:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=sbof/qLn+dOQrA0pLRhhBfo0WnNOpglgyymvixy8y80=; b=HHB2+VW8EP347cU0gE/OcR/4Iq
	apE2rVV7AZuFJutorB86uX57TGgePwSzOXVt069gHcHGSuUqoucAGfUAVs3jCRJLRJ5wy5HdkWU95
	TCNGCWwgXobUfRelFFJK1+gIYwpJ0MELAr3Orll+kqKnIh7Zts0QJMsS5vSXvp3hgyXM=;
Received: by mail.inix.me with esmtpsa (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
	(Exim 4.96)
	(envelope-from <dash.btrfs@inix.me>)
	id 1raz0N-00A5Ua-0K;
	Fri, 16 Feb 2024 14:15:55 +0000
Message-ID: <29b50a95-025d-41c3-bee6-f51888b28487@inix.me>
Date: Fri, 16 Feb 2024 19:34:22 +0530
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: incremental stream after fstrim on thinly provisioned disk file
Content-Language: en-US
From: Dorai Ashok S A <dash.btrfs@inix.me>
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org
References: <c0bf7818-9c45-46a8-b3d3-513230d0c86e@inix.me>
 <CAL3q7H6tvCTdwrCXZ0tgOfkHhF=VWEW05_u3vr_rVv0u_PvvXg@mail.gmail.com>
 <20b3b98b-b165-4fd7-b026-8f3c8440a631@inix.me>
In-Reply-To: <20b3b98b-b165-4fd7-b026-8f3c8440a631@inix.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: dash.btrfs@inix.me


 > seq 10000000 > 76mb.file

This should be: seq 10000000 > thin-mount/76mb.file

Either ways, I get a large send stream (2.5GB / 2.8GB)

Regards,
-Ashok.


