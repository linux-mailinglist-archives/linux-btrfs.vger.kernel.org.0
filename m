Return-Path: <linux-btrfs+bounces-1063-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD35E819060
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Dec 2023 20:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CEC51F25528
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Dec 2023 19:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640A539AC2;
	Tue, 19 Dec 2023 19:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=inwind.it header.i=@inwind.it header.b="s42+RUYC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from libero.it (smtp-16.italiaonline.it [213.209.10.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7852439877
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Dec 2023 19:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=inwind.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inwind.it
Received: from [192.168.1.27] ([84.220.171.3])
	by smtp-16.iol.local with ESMTPA
	id FfT4rD4EAOtSyFfT5rUcSg; Tue, 19 Dec 2023 20:09:27 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
	t=1703012967; bh=MR6vlK2Obefj9OwR4YYF9OFWkoqxo4+obTiZJyHmzQ0=;
	h=From;
	b=s42+RUYCIcsuuhOrkSjkj0Bgrzs4MOUOQM9u5s6aiJcqWTlFVOaAJov2rBucMg1cJ
	 eysj+9vOe8Zsqltr5WHW5OUbkw8d3EIDrCnmfbNbVczDDDE4tQ6vmbI8/Wucto6Knu
	 PWC4fis+gYUkpTtTEpNO9App7yLiz5rlU//bX/MVnHXanVW6HxBSKIflmLSt/eKzsu
	 v2e3o4WOL4yuGMLE+APyCDfQbW5bTD8pWVnAjmQE+reBraM4IJhhhrA8TP9A5I1wse
	 z8V5YIWUpTAXeCwDVkZsb6gcYeThUH3B4pLfQM/WASEDZKvGSE0rHiUybJyjjR3OhF
	 M8tElWm8kD2Nw==
X-CNFS-Analysis: v=2.4 cv=Qf+g/OXv c=1 sm=1 tr=0 ts=6581ea67 cx=a_exe
 a=hciw9o01/L1eIHAASTHaSw==:117 a=hciw9o01/L1eIHAASTHaSw==:17
 a=DZp_LHW8HzMn4gUu:21 a=IkcTkHD0fZMA:10 a=PklY5DowAAAA:8
 a=2qX1Xo0blAHU-vJPGLoA:9 a=QEXdDO2ut3YA:10 a=ndd1GwnyhXTyTHCeb75D:22
Message-ID: <9bb4ead3-2e98-4d0f-a980-1d53847c8b99@inwind.it>
Date: Tue, 19 Dec 2023 20:09:26 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: kreijack@inwind.it
Subject: Re: btrfs thinks fs is full, though 11GB should be still free
To: Andrei Borzenkov <arvidjaar@gmail.com>,
 Christoph Anton Mitterer <calestyo@scientia.org>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <0f4a5a08fe9c4a6fe1bfcb0785691a7532abb958.camel@scientia.org>
 <253c6b4e-2b33-4892-8d6f-c0f783732cb6@gmx.com>
 <95692519c19990e9993d5a93985aab854289632a.camel@scientia.org>
 <656b69f7-d897-4e9d-babe-39727b8e3433@gmx.com>
 <cf65cb296cf4bca8abb0e1ee260436990bc9d3ca.camel@scientia.org>
 <f2dfb764-1356-4a3c-81e8-a2225f40fea5@gmx.com>
 <f1f3b0f2a48f9092ea54f05b0f6596c58370e0b2.camel@scientia.org>
 <3cfc3cdf-e6f2-400e-ac12-5ddb2840954d@gmx.com>
 <2d5838efc179a557b41c84e9ca9a608be6a159e8.camel@scientia.org>
 <9ce30564e238d1be0deafb8cab8968f800a8deaa.camel@scientia.org>
 <8a9b6743-37e6-4a71-9423-6ce5169959ac@gmx.com>
 <62e9ad23d4829f30600ea6e611d2cd4636f080cc.camel@scientia.org>
 <7acc8ea1-079d-42bb-8880-dbd9bbfa100b@libero.it>
 <fecad7ce2cea1ff125a842d8c53f1fbfe4f1d231.camel@scientia.org>
 <CAA91j0VNf9UQTYOn688eboGB_bw4YeKOXnKAt1uAYRZwYA3UPg@mail.gmail.com>
Content-Language: en-US
From: Goffredo Baroncelli <kreijack@inwind.it>
In-Reply-To: <CAA91j0VNf9UQTYOn688eboGB_bw4YeKOXnKAt1uAYRZwYA3UPg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfCS/quOt0hOO+G0s7Ds0O/rzPF+5N2vxXTon4CRIdmchPDivMjnetl6Acn2W9MiFMkAaemK1ykqD+fplIPXZDCEky3BoYK/52GmNx/uxQgL4OXtBBJiW
 fx28MmlauOXpfaYfR5CC2j+G6hqO3ZKY58pA200yKcmar2EqaTBDfKzl25tOtQQFV1G+Kfya7bpklz0XsiIfdxrFHB84zzSWjuhpPXtGkgGdsnuNcHRbQb78
 NywGZ0rcjHtxb1s7E+gBsZ4/Bvdxsa092OriSgWQAo+r+nGt3njOkhpSE7MkeNMx

On 19/12/2023 09.22, Andrei Borzenkov wrote:
> On Tue, Dec 19, 2023 at 4:00 AM Christoph Anton Mitterer
> <calestyo@scientia.org> wrote:
>
> 
> /data/main/prometheus/metrics2/01HHFEZPJ8TPFVYTXV11R7ZH4X/chunks/000001
> Processed 1 file, 1 regular extents (1 refs), 0 inline.
> Type       Perc     Disk Usage   Uncompressed Referenced
> TOTAL      100%      256M         256M          15M
> none       100%      256M         256M          15M
> 
> I would try to find out whether this single extent is shared, where
> the data is located inside this extent. Could it be that file was
> truncated or the hole was punched in it?
> 

Ok, now we have the case study.
To be sure, could you try a defrag (+ sync) of this single file ?

The what is the lsof output ?

Does anyone know a way to extract the "owners" of an extent ? I think that
we should go through the backref, but I never did. I don't want to
re-invent the wheel, so I am asking if someone knows a tool that can
help to find the owners of a extent.

BR

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5


