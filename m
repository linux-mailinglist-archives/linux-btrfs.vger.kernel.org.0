Return-Path: <linux-btrfs+bounces-2654-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC54860803
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Feb 2024 02:07:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F867B2227D
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Feb 2024 01:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB0AC2E9;
	Fri, 23 Feb 2024 01:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b="eCPtdtmR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kvwm/INw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985B8BE7F
	for <linux-btrfs@vger.kernel.org>; Fri, 23 Feb 2024 01:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708650408; cv=none; b=X+KfK9dAzpWqWuN6JaeAxISnRHYxBBtjMlZMB1LWlp/SMDN+N0EEMpN473AkdtKGl3E6fbQcnVWbjy4xzxMqTEsTLGAGiyQDP2ot8SWSAtuTMYuoLLJ05hg4CSGKBSFTssnZTTe+3KDFdneURDljjiGvgmrcdqNdEfJVezoZdsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708650408; c=relaxed/simple;
	bh=B/vIRDfzx02F213bdbkAheuqKbP2Cb20iYu5zv+mbDE=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:
	 Subject:Content-Type; b=J9eXORVlJKBJMHfv+oLxKRWntw2xU4yNv/EdtmmHJV2sZUWuH3JShhNZgRGoLgHtb5N1I3Tob6G6SFoIkkBA7qDZuAM1a+z6zVmQICjvjbsIEVlquukEw6HwGxlh+uzcX8ibS5Oq/BeGE5SGYnjqlw5jfVoXAwZqLERUoe2lWrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=colorremedies.com; spf=pass smtp.mailfrom=colorremedies.com; dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b=eCPtdtmR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kvwm/INw; arc=none smtp.client-ip=64.147.123.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=colorremedies.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=colorremedies.com
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.west.internal (Postfix) with ESMTP id 95E943200A32;
	Thu, 22 Feb 2024 20:06:45 -0500 (EST)
Received: from imap50 ([10.202.2.100])
  by compute4.internal (MEProxy); Thu, 22 Feb 2024 20:06:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	colorremedies.com; h=cc:content-type:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1708650405; x=
	1708736805; bh=8oAzIhp4x3r8xh5pTeyxL5PLGOjmScT9/H7lyYMtlos=; b=e
	CPtdtmRJ7tBm6aWOAHMfpc/Nkbk4aSioCxlC7XM6QkbjlqsAwqhUDpBGGB0lQ0Se
	rPA4JbhzQXAnSqk8Lhvt5ubdvdGYEQI3YhtIjJLjJLZ1QhRKziMQaD7+dOZcmYLM
	DVzNk0vzocLQKX7b8mZEXcwmoRB0NV7hjk3c8uUzSWoe238Br5TTIP+ZwMyGlthT
	dgOq567F5j0nBoZRCMpwkq0StmaqutEYgaOXVMoPud5+DSPa7WMRtYYhWmjx9ayT
	lReAPhp5V5SKAZ98w6WJORwCCMKatszN6QoHn8iPCwZHx4g1N0ti4fdX8Rylj3kv
	EmpOzT9xgD5lvocfoqVhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708650405; x=1708736805; bh=8oAzIhp4x3r8xh5pTeyxL5PLGOjm
	ScT9/H7lyYMtlos=; b=kvwm/INwI55MvHMqmCiN7yvh/+VkwpuOwsDkOvUdv180
	Q84nlyCM2DTBnNJzvc28DJ11G+tVff5tRpfOk/dugXEBloMyiX4Eexewhp7ytwsd
	lyimUx2CZMnOSZgemdpaVCNDns/9TX3KBaZ5hSiPRikRXkh32prv0Fq4fwpD85t/
	eAUkTEAzIWzrdq+tO28xytYOjul0MlGBrpcdTcLR73PxrXs1g6IRO8SQDgURp4bA
	wv7yqiV143fVpEs4rArOqW/dBY8Mz7uw8uYFseqNs27ReMyBhDbD2cvfX4IhIsPQ
	uWtusctxbw4x07B7NV1e2zGleTg0a5Ghql6yUBQPDA==
X-ME-Sender: <xms:pO_XZRY3cwj4vbxNdBi0TMyCAoEsJ0h21DjONVTqx59Dm8tLAGpgyQ>
    <xme:pO_XZYZUykBZuaeRKnEF2w3JfQ4GEZdRXWmg-_6sNvy9db2JenLImcVUz9zLvuIY0
    qhKNZ3gX8-RYqcLZ9I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeehgddvlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedfvehhrhhi
    shcuofhurhhphhihfdcuoehlihhsthhssegtohhlohhrrhgvmhgvughivghsrdgtohhmqe
    enucggtffrrghtthgvrhhnpeduheeiveeutefghfekteekleevffeuledtjedvjeevvedv
    gefgfefhgedvudegueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehlihhsthhssegtohhlohhrrhgvmhgvughivghsrdgtohhm
X-ME-Proxy: <xmx:pO_XZT-5_nTruyQtoJSNu45QvbyUdv3cMzTluiQNLgf4SV1yANQ6aw>
    <xmx:pO_XZfrl2lf65GNZLdfZGKorGR576pCw2L8JKhnCRt60YV8dEWwHqw>
    <xmx:pO_XZcpLjh0q5Jhm9WlqOTrp5i5EFLid4f0nDSJKk1D0TQwLjUvINg>
    <xmx:pe_XZTQfTFmUmNi1qDQqw2V2u7scLnSeA1tI-W1SHLaN4lstd6EMXA>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id CA9A11700096; Thu, 22 Feb 2024 20:06:44 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-153-g7e3bb84806-fm-20240215.007-g7e3bb848
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b235b81b-6a84-4026-adf0-9d4f202ea890@app.fastmail.com>
In-Reply-To: <7f994558-e786-4bc1-97bc-7090b9955de3@gmx.com>
References: <5bd227d2-187a-4e0a-9ae8-c199bf6d0c85@web.de>
 <1597160e-0b54-403b-8e9d-9435425f14f3@gmx.com>
 <2790f277-fc10-43fc-b7d3-9a3cef1eced2@web.de>
 <7f994558-e786-4bc1-97bc-7090b9955de3@gmx.com>
Date: Thu, 22 Feb 2024 18:06:23 -0700
From: "Chris Murphy" <lists@colorremedies.com>
To: "Qu Wenruo" <quwenruo.btrfs@gmx.com>, Roland <devzero@web.de>,
 "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Subject: Re: apply different compress/compress-force settings on different subvolumes ?
Content-Type: text/plain



On Wed, Feb 21, 2024, at 8:25 PM, Qu Wenruo wrote:

> OK, didn't expect the compression ratio detection to cause so much
> difference.
>
> Which also means, we can further improve the compression detection.
>
> In that case, I would purpose to change "compress-force" to
> "skip_compress_heuristic" or something similar, and get rid of the
> compression string/level for the new option.

But which heuristic is skipped? I assume it can only be the btrfs built-in one? I'm not sure about other compression algorithms but zstandard has its own bail-out heuristic.

Another potentially large difference between compress and compress-force is extent size is limited to 512 KIB even when not compressed using compress-force. Whereas the upper limit on extent size for compress option, is (I think) bg size. An upper limit of 512 KiB on extent size can significantly increase the metadata requirement, leading to tall trees. That then makes me wonder if such setups should have a larger node/leaf size than 16KiB default. 

I'm also not sure which heuristic is cheaper, or more accurate, the built-in Btrfs one or zstandard.


-- 
Chris Murphy

