Return-Path: <linux-btrfs+bounces-19882-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C12CCCE4B2
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Dec 2025 03:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9C35B30253F8
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Dec 2025 02:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0926E26CE2B;
	Fri, 19 Dec 2025 02:50:34 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-m49244.qiye.163.com (mail-m49244.qiye.163.com [45.254.49.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078F222A4D6
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Dec 2025 02:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.244
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766112633; cv=none; b=NDWNJ0DudChIBicDQgg+SCrGGRt2LgR90e1BmCsvTfo0Pdcl7cjmgyeTej9izST+MpboOF/7xlBOMwLaJdCFI5MZiwGdgce2LrT3Mw9itaYis12NcCYkSXkqtCfcFGgYRTtvtCDuEldk5eACPAc/YMBJ4IUeO29ipvYyEHk0e4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766112633; c=relaxed/simple;
	bh=ilTNinqlT5OmL54qFu8wM2ZhpCIyvWBgukGfr4EyjNk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fnCVZhHjTucklf/sfYCiQkDrZjJ6kIvMmmQLMPo0NTw8rJAMZq8rvKzDCdax3GJ3hNtOnXdSuB6xDXfnJut6xGGZ52das0kgWQWU03kbTqp9cZKn+JS7GdZ6lCXUyOlH5FhDjYRljbuwBmvEgqORKAiIJ3IQNKGRgpuQn7x+3KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn; spf=pass smtp.mailfrom=easystack.cn; arc=none smtp.client-ip=45.254.49.244
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=easystack.cn
Received: from [192.168.0.18] (unknown [218.94.118.90])
	by smtp.qiye.163.com (Hmail) with ESMTP id 148c5d26d;
	Fri, 19 Dec 2025 10:50:19 +0800 (GMT+08:00)
Message-ID: <2b992fc4-cb47-4733-bee4-c670ed6a3401@easystack.cn>
Date: Fri, 19 Dec 2025 10:50:18 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: remove assertions after btrfs_bio struct changes
To: dsterba@suse.cz
Cc: clm@fb.com, dsterba@suse.com, wqu@suse.com, linux-btrfs@vger.kernel.org
References: <20251218122215.1044381-1-zhen.ni@easystack.cn>
 <20251218135725.GO3195@suse.cz> <20251218140536.GP3195@suse.cz>
From: "zhen.ni" <zhen.ni@easystack.cn>
In-Reply-To: <20251218140536.GP3195@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9b3483ead20229kunm8f2c380c70db45
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVkZTE0dVkwaTBhDQkIZHxlJHlYVFAkWGhdVGRETFh
	oSFyQUDg9ZV1kYEgtZQVlJSkNVQk9VSkpDVUJLWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
	VKQktLWQY+



在 2025/12/18 22:05, David Sterba 写道:
> On Thu, Dec 18, 2025 at 02:57:25PM +0100, David Sterba wrote:
>> On Thu, Dec 18, 2025 at 08:22:15PM +0800, Zhen Ni wrote:
>>> Commit 81cea6cd7041 ("btrfs: remove btrfs_bio::fs_info by extracting it
>>> from btrfs_bio::inode") modified the btrfs_bio structure to make the
>>> inode field mandatory, making these assertions redundant:
>>>
>>> - btrfs_check_read_bio(): inode is validated by btrfs_bio_init()
>>> - btrfs_submit_bbio(): condition always passes since inode is never NULL
>>>
>>> Remove these obsolete checks.
>>
>> The assertions may be redundant and their purpose is to catch accidental
>> changes to code or explicitly list some critical assumptions. We'd like
>> to have more rather than fewer of them.
> 
> https://btrfs.readthedocs.io/en/latest/dev/Development-notes.html#handling-unexpected-conditions
> 
> 

Thank you for pointing out the relevant documentation.

Maintaining these assertions (or even adding more) is the better 
approach. They not only prevent current errors but, more importantly, 
prevent future code modifications from introducing problems.

