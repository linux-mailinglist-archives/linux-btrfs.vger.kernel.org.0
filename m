Return-Path: <linux-btrfs+bounces-7526-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D3995FCB7
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 00:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64040283D4E
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2024 22:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7FD19D889;
	Mon, 26 Aug 2024 22:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kLdqau8p"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C4519CD1D;
	Mon, 26 Aug 2024 22:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724711239; cv=none; b=r2RtBD0UxFGJAZQf7cTVlpkU6WFTgRVYKCRzozQ1o5HCEl8/iuVnsgRrmLJ9fMVFzsgYQEYY6339fF1J8kiGMMjgl1Xxru6UlD068WOSyfwpffYKB/PS8psz7eknlvcpIelLRSPSU8NgSooIiOhwJvog5+xdONR3+o9+o+h9vgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724711239; c=relaxed/simple;
	bh=YUKs1KBE09pUkly3gguvzGzbyUk4EPOCB3hXo8c5+MI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TsObCq6pfzyRAy/dvq4xBD7x7LYstJWCaDP5LPCnE1jS8B+4WrEhNpF0Z5y3RgUMWZ0SL+zpty8M8T4qE3cPNvKtzmhUHOKCsvkWWhQwsv9l0H9Bb6EgzzIYcVbR5B8wcRJBKQ/tIrxbwoXzYSGHPk3HPTm3oxBzztDST4ULGMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kLdqau8p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B461C8B7A7;
	Mon, 26 Aug 2024 22:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724711239;
	bh=YUKs1KBE09pUkly3gguvzGzbyUk4EPOCB3hXo8c5+MI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kLdqau8pL1Vgnev0P2scPfg56W1npUE6iRODU9dbFc6/6NhqUfDtDEcb4tFcYrqGV
	 TkG8ZEIgE6n92BOYzlVAm9FoNhWF50GXf9UbnmzJHrwxYP64MwNO74t71ZlohtRGu8
	 5XZhtDoXa4W0ZllyCFb2sJca4fwItRylNtleBbqBn2DD0dWBPEUpYX7CEJhhhG2Dg/
	 4NF7QDv8VIByQTZb7KPID4bqXEKLJVubk5SX1O8NwWx4SP1epSbhAQgTmFOVJA5Ghs
	 HzbV6tBeFL+6mrwvjSOpi21RZdDBivHvV1GCkvjS1DBNt6LZWMgeCRU4FYNP9Z0AmA
	 aWlygmByZsETQ==
Message-ID: <124a9588-b7ce-4444-b4e7-d06041f54f2c@kernel.org>
Date: Tue, 27 Aug 2024 07:27:17 +0900
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] block: constify the lim argument to
 queue_limits_max_zone_append_sectors
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, Hans Holmberg <Hans.Holmberg@wdc.com>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <20240826173820.1690925-1-hch@lst.de>
 <20240826173820.1690925-3-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240826173820.1690925-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/27/24 02:37, Christoph Hellwig wrote:
> queue_limits_max_zone_append_sectors doesn't change the lim argument,
> so mark it as const.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research


