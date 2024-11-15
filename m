Return-Path: <linux-btrfs+bounces-9740-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA199CFB75
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Nov 2024 01:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 494501F2395A
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Nov 2024 00:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84AD2632;
	Sat, 16 Nov 2024 00:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="sGiGMVNS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CD9161
	for <linux-btrfs@vger.kernel.org>; Sat, 16 Nov 2024 00:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731715898; cv=none; b=b/kI77Wj3kqsaYoY2pjxJqiDxePTlOwy6FR40gGacfCcyI8YHWiMmbfLfSlQc/j0V6Zu5Zoqxc1ZSl+rzL5OgEwrOe4WCPCbgFkcjcjnaqW2crCbdeYiUnQ8oxg5+tbLUaQjqhSO0eqhjDXhSl84AC1ltjfIAjvDCmJR853E7sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731715898; c=relaxed/simple;
	bh=ZDd22aLXsHUlz+/sWCHa722WxZWgpdc2GQHlchHZLq0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=ALocc3269bpC2IliSXkuQWedgGzdTwX1iCHBQKJMVG149SzW9HxIIonX4AYRJ5554bPWjgFPXo/V2v4NVW54SB+BZjy6LpeRzOQXGTpbi+zpHdkk6tqhLXAjbYDD3mzXG8tf2vNz6nHLplEdWE5IZbf+e4t89cmVGMKE5EKVGug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=sGiGMVNS; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20241116001127epoutp026d1e86fc267209da4f4083c37f939d3a~ISmyvFp362145121451epoutp02j
	for <linux-btrfs@vger.kernel.org>; Sat, 16 Nov 2024 00:11:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20241116001127epoutp026d1e86fc267209da4f4083c37f939d3a~ISmyvFp362145121451epoutp02j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1731715887;
	bh=No3ppOzw7WEg6GIw4Zr2BqJS8f5DrhfSGHVofyxaJIo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sGiGMVNSrmJSt/z40HWxqsR/Ha6J6ylnZ7upphyk3rBgG1+TzZ7gSKNBsDx/vNoxo
	 LLJm9NmY/YeaWIsoaaOPpmC1NCH3iRuRDHdPYgIDBhUjMUIdA7l8sehlz9H3rFa2Eo
	 zCjMcMLOL1BmkXW0nXuYIV63dq2n/NqSmRHLis3Q=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20241116001126epcas5p4d7097a4556cbfa2491227ebc7bff47b7~ISmx-dVN62680926809epcas5p4J;
	Sat, 16 Nov 2024 00:11:26 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.178]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4XqvSY2dsxz4x9Pw; Sat, 16 Nov
	2024 00:11:25 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	16.F3.09770.D23E7376; Sat, 16 Nov 2024 09:11:25 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20241115030334epcas5p3e8a335a111b09c1296ff7dc67b5413e7~IBTyscmMu2125921259epcas5p3C;
	Fri, 15 Nov 2024 03:03:34 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241115030334epsmtrp13937b100d1965fd6919ce373c80441de~IBTyr1xBE0185801858epsmtrp1D;
	Fri, 15 Nov 2024 03:03:34 +0000 (GMT)
X-AuditID: b6c32a4a-e25fa7000000262a-e5-6737e32d1b92
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	C3.26.18937.60AB6376; Fri, 15 Nov 2024 12:03:34 +0900 (KST)
Received: from dpss52-OptiPlex-9020.. (unknown [109.105.118.52]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20241115030333epsmtip12461f9f6bda722200de1a8c5450411b1~IBTxpTgjJ2706327063epsmtip1O;
	Fri, 15 Nov 2024 03:03:33 +0000 (GMT)
From: Jing Xia <j.xia@samsung.com>
To: dsterba@suse.cz
Cc: clm@fb.com, dsterba@suse.com, j.xia@samsung.com, josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org
Subject: Re: Re: Re: [PATCH] fs/btrfs: Pass write-hint for buffered IO
Date: Fri, 15 Nov 2024 11:05:12 +0800
Message-Id: <20241115030512.3319144-1-j.xia@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240920055208.29635-1-j.xia@samsung.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBJsWRmVeSWpSXmKPExsWy7bCmlq7uY/N0g19LBC0m9c9gt7jwo5HJ
	YvHv7ywWO5etZbf4uGc1k8Wfh4YWlx6vYLc4O+EDqwOHx8Tmd+wefVtWMXqs33KVxePMgiPs
	HhM2b2T1+LxJLoAtKtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE31VbJ
	xSdA1y0zB+geJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BSYFecWJucWleul5e
	aomVoYGBkSlQYUJ2xoHZj9gLznBVPLh+i7WBcR1HFyMnh4SAicTOR+sZuxi5OIQEdjNKTGr9
	wAThfGKU+HniBTOc8+/HclaYlj97r0EldjJKXLh/mRXC+coosaZhDyNIFZuAksSdRWeYQWwR
	AWGJBWtPA83l4GAWyJD48TMTJCws4CaxbPNRsHIWAVWJR28OsIDYvAIWEidnT2aDWCYvsf/g
	WbAxnALmEpPfXGeGqBGUODnzCVg9M1BN89bZzBD1X9klPq0MhbBdJNpvfoWKC0u8Or6FHcKW
	knjZ3wZlF0s0T33NAnK/hEADo0TD6V+MEAlriW3r10HdrCmxfpc+RFhWYuopkDDIXj6J3t9P
	mCDivBI75sHY8hKP1s5gBmmVEBCV+LtKEiLsITFv0V1oUHcxSmxbNJ11AqPCLCTvzELyziyE
	zQsYmVcxSqYWFOempxabFhjlpZbDIzk5P3cTIziJanntYHz44IPeIUYmDsZDjBIczEoivJdc
	zdOFeFMSK6tSi/Lji0pzUosPMZoCw3sis5Rocj4wjeeVxBuaWBqYmJmZmVgamxkqifO+bp2b
	IiSQnliSmp2aWpBaBNPHxMEp1cAUVennmPfumIT7XiWdp4wV7ip/6zw6KkIdc4L2SKScS5J6
	WxYRWLjl3KzSafseWN6X6E0xCnj97t/9H4+25a0WunPJwdLw7tFZKW19f/7IusqXHD0ss+d4
	nn3H008BezVKFzyJmp93sPh8wkOVhx+X+nsf+PHdfgVPTIn386jpD98pPNrF2v56vZ/w5A+n
	VZbfjLs/o6p0tuAyuZZ5ucktX67Mi9vfdNon6MQy7Zw/JT5vviknbNh2dv9ESanDRxa+Nsh4
	rf7y1+3TLwuvKYUJe8qcOvqOyWemqHdYSfvWEBHWxt+3A7MFwrdybPIV/Ro44+68BkmdyniF
	Z+wbuRLE/VMCndjVbqv7qU5y7hdVYinOSDTUYi4qTgQAyJyQNCsEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJLMWRmVeSWpSXmKPExsWy7bCSnC7bLrN0g/2P9Swm9c9gt7jwo5HJ
	YvHv7ywWO5etZbf4uGc1k8Wfh4YWlx6vYLc4O+EDqwOHx8Tmd+wefVtWMXqs33KVxePMgiPs
	HhM2b2T1+LxJLoAtissmJTUnsyy1SN8ugSvjwOxH7AVnuCoeXL/F2sC4jqOLkZNDQsBE4s/e
	a8xdjFwcQgLbGSXuHm1kgUiISlw5e5gNwhaWWPnvOTuILSTwmVFidUMRiM0moCRxZ9EZZhBb
	BKhmwdrTTF2MHBzMAnkSl5/pg4SFBdwklm0+yghiswioSjx6cwBsPK+AhcTJ2ZOhxstL7D94
	FmwMp4C5xOQ315lBxggJmElcW+QDUS4ocXLmE7BWZqDy5q2zmScwCsxCkpqFJLWAkWkVo2hq
	QXFuem5ygaFecWJucWleul5yfu4mRnBoawXtYFy2/q/eIUYmDsZDjBIczEoivKecjdOFeFMS
	K6tSi/Lji0pzUosPMUpzsCiJ8yrndKYICaQnlqRmp6YWpBbBZJk4OKUamArOnn2040RKz8t9
	102sLBrVOGbNfL8y4YOz57Sth37tEr9WGXTxRJtNguwFbS6/i3fuJjty6bxOuj5/U5BbwQr+
	re36x8tzRXNLrqSFR1cLmDc1rzZt96yw9WaIZ7e3+lRlXc09MW6nzc9op87vZ6et2WF3Zce7
	ojlLb/TsqY5yWtz+eEL7Ke8UeWZmTaO4hRXfReUP3Hixe+7ile/Md3a/K5t/V2DLjqsbnm2u
	KAppacyb/r+pSp3FM+H8zf2rBS5uc9nVabBA66aMjeH9r+yrzNZr3u3R7jp6R/vSszSX+cy1
	b1K0D3TUOs+zV9tneqyL6QRjjcTPirt/Nkmve+mgk3z+neSy7ef/lGt8rFNiKc5INNRiLipO
	BAC43uLk3AIAAA==
X-CMS-MailID: 20241115030334epcas5p3e8a335a111b09c1296ff7dc67b5413e7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241115030334epcas5p3e8a335a111b09c1296ff7dc67b5413e7
References: <20240920055208.29635-1-j.xia@samsung.com>
	<CGME20241115030334epcas5p3e8a335a111b09c1296ff7dc67b5413e7@epcas5p3.samsung.com>

> > On Tue, Sep 03, 2024 at 01:40:12PM +0800, j.xia wrote:
> > > Commit 449813515d3e ("block, fs: Restore the per-bio/request data
> > > lifetime fields") restored write-hint support in btrfs. But that is
> > > applicable only for direct IO. This patch supports passing
> > > write-hint for buffered IO from btrfs file system to block layer
> > > by filling bi_write_hint of struct bio in alloc_new_bio().
> > 
> > What's the status of the write hints? The commit chain is revert,
>   
>   "enum rw_hint" include/linux/rw_hint.h defines the status.
> 
> > removal and mentioning that NVMe does not make use of the write hint so
> > what hardware is using it?
> 
>   New NVMe Flexible Data Placement (FDP) SSD (TP4146) is able to 
>   use hint to place data in different streams. 
>   The related patch is
>   Link: https://lore.kernel.org/all/20240910150200.6589-6-joshi.k@samsung.com
> 
> > 
> > The patch is probably ok as it passes the information from inode to bio,
> > otherwise btrfs does not make any use of it, we have heuristics around
> > extent size, not the expected write lifetime expectancy.
> 


fcntl() interface can be used to set/get write life time hints.
Now the write hint can be passed from inode->i_write_hint to
bio->bi_write_hint for direct IO. This patch completes this
feature for buffered IO.

>

