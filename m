Return-Path: <linux-btrfs+bounces-6680-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69BB393B1A5
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jul 2024 15:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D47F1F230AC
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jul 2024 13:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF61152511;
	Wed, 24 Jul 2024 13:31:05 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5F353A9;
	Wed, 24 Jul 2024 13:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721827864; cv=none; b=I77DAF2qHV7PYc5AEJcLc0BTP2FApd110UFKXDpI9X0GoxKqzBhYKld1wIWakb89DW8KYaoSVUGkCXjmwFXYHISGQWc/Wnt0f3HpSaE5ZX727CcXFTqVs3A0/iBzS8ZfvnKTtSDtjOAoJhEy2v/b8ZlVLt/bwVaKcx3ZMVZbpys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721827864; c=relaxed/simple;
	bh=gc4Zge0Fa+tisFmvWqz1nO+VZ3ckA5xFvk+K4tZCFHU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=keVNlUzlF6wlS4wU2DPHVERRepyudhdZabo/haD98kKTdcLyD/eoH1aVoRaC6rJ/DY6kMteAl8fXJrjwWa1y0Gmfrnkubww3HpXn95UJOvKviX9ftg2ozMpqIUM5n33T8bn0huRDML7V4i+6W256YfTjQPN77KcAls6GcDjcZM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WTZXc4xk4zyN5G;
	Wed, 24 Jul 2024 21:26:08 +0800 (CST)
Received: from kwepemf100006.china.huawei.com (unknown [7.202.181.220])
	by mail.maildlp.com (Postfix) with ESMTPS id 629FA180087;
	Wed, 24 Jul 2024 21:30:59 +0800 (CST)
Received: from [10.174.177.210] (10.174.177.210) by
 kwepemf100006.china.huawei.com (7.202.181.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 24 Jul 2024 21:30:58 +0800
Message-ID: <4188b7b5-3576-9e5f-6297-794558d7a01e@huawei.com>
Date: Wed, 24 Jul 2024 21:30:57 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] generic/736: don't run it on tmpfs
To: Filipe Manana <fdmanana@kernel.org>, Christoph Hellwig
	<hch@infradead.org>, <chuck.lever@oracle.com>
CC: <zlang@kernel.org>, <fstests@vger.kernel.org>, <linux-mm@kvack.org>,
	<hughd@google.com>, <akpm@linux-foundation.org>, linux-btrfs
	<linux-btrfs@vger.kernel.org>
References: <20240720083538.2999155-1-yangerkun@huawei.com>
 <CAL3q7H5AivAMSWk3FmmsrSqbeLfqMw_hr05b_Rdzk7hnnrsWiA@mail.gmail.com>
From: yangerkun <yangerkun@huawei.com>
In-Reply-To: <CAL3q7H5AivAMSWk3FmmsrSqbeLfqMw_hr05b_Rdzk7hnnrsWiA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemf100006.china.huawei.com (7.202.181.220)

Hi, All,

Sorry for the delay relay(something happened, and cannot use pc
before...).

在 2024/7/21 1:26, Filipe Manana 写道:
> On Sat, Jul 20, 2024 at 9:38 AM Yang Erkun <yangerkun@huawei.com> wrote:
>>
>> We use offset_readdir for tmpfs, and every we call rename, the offset
>> for the parent dir will increase by 1. So for tmpfs we will always
>> fail since the infinite readdir.
> 
> Having an infinite readdir sounds like a bug, or at least an
> inconvenience and surprising for users.
> We had that problem in btrfs which affected users/applications, see:
> 
> https://lore.kernel.org/linux-btrfs/2c8c55ec-04c6-e0dc-9c5c-8c7924778c35@landley.net/
> 
> which was surprising for them since every other filesystem they
> used/tested didn't have that problem.
> Why not fix tmpfs?

Thanks for all your advise, I will give a detail analysis first(maybe
until last week I can do it), and after we give a conclusion about does
this behavior a bug or something expected to occur, I will choose the
next step!

Thanks again for all your advise!


> 
> Thanks.
> 
>>
>> Signed-off-by: Yang Erkun <yangerkun@huawei.com>
>> ---
>>   tests/generic/736 | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tests/generic/736 b/tests/generic/736
>> index d2432a82..9fafa8df 100755
>> --- a/tests/generic/736
>> +++ b/tests/generic/736
>> @@ -18,7 +18,7 @@ _cleanup()
>>          rm -fr $target_dir
>>   }
>>
>> -_supported_fs generic
>> +_supported_fs generic ^tmpfs
>>   _require_test
>>   _require_test_program readdir-while-renames
>>
>> --
>> 2.39.2
>>
>>

