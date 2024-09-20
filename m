Return-Path: <linux-btrfs+bounces-8141-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC6597D10A
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Sep 2024 08:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 569A71F225B1
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Sep 2024 06:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DACCB4084D;
	Fri, 20 Sep 2024 06:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="NnbbVq1t"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C702E5661
	for <linux-btrfs@vger.kernel.org>; Fri, 20 Sep 2024 06:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726812086; cv=none; b=gtz4nLP4YLG0LjZ3XQJeZ70roh1H4ZgGB/HFDwd7xdpcZ0WdH4bGnMvcHinAc9o7hdsvMsyzbDo4oZ3c2qDwzxq+L/L/SlDjRqjDPz9OGqpcgeD/y4RloJnMPQRXBWhIuRJ3IIFSBRN2kBbxJANGVL0jVowUWOS2KgRNBbvY35k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726812086; c=relaxed/simple;
	bh=rTa4EgbmILCAYtb/mNpoxJYpM5ytan4D3mQuwE+7D8M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=DmYyi4b6ZHe+C3jUX8fGHj+YRwcRTc8vEQaJjxUpU6kap8FTaEWzLCB1CJVvQSySYCSc9imnrhXQ3jBJG/wJVwqq0BpYdZhXerOaNtb804gh0V5EmrkqvzynvJ7Q9jus3SZxRcdn+X/filyvLyQJDcFCb1g4IyF1RjtLslZRbvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=NnbbVq1t; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240920060121epoutp022e365b3a68b1158f9114fb5323bae13d~23nBzLCRO2860028600epoutp02q
	for <linux-btrfs@vger.kernel.org>; Fri, 20 Sep 2024 06:01:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240920060121epoutp022e365b3a68b1158f9114fb5323bae13d~23nBzLCRO2860028600epoutp02q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1726812081;
	bh=aqtPKd+j8XkTvGeVEIasBG1zys+ecurLaF/n2yQUyEA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NnbbVq1tS47Y3likl91KSOsB13LlwsCjuatdZm5oEeImZd5Qe5uUf4VbzfnQKFXTK
	 XmIYsChFGWXIMsq6JebcWd77C/rSlt2HqN+QmE9B6cQvuVYIxCjxqnSSKh70yYWoSq
	 bTaylKkg5WPNZERH1n1CShfxcN1KnH+X5w28kiZs=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20240920060121epcas5p23f66f94d3b424c129f8f4c86b3f7b139~23nBgld9e1671616716epcas5p2K;
	Fri, 20 Sep 2024 06:01:21 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.181]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4X91wc1ssXz4x9Pp; Fri, 20 Sep
	2024 06:01:20 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	9A.8E.09743.DAF0DE66; Fri, 20 Sep 2024 15:01:17 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240920055058epcas5p29d7d9fac2d1c71c33eb51ee02d70cf8b~23d9XbCW32249822498epcas5p20;
	Fri, 20 Sep 2024 05:50:58 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240920055058epsmtrp1b56b60251e2469aeda08b472f89dd549~23d9WkvC41666816668epsmtrp1K;
	Fri, 20 Sep 2024 05:50:58 +0000 (GMT)
X-AuditID: b6c32a4a-3b1fa7000000260f-d0-66ed0fadd4b9
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	9B.DF.08456.24D0DE66; Fri, 20 Sep 2024 14:50:58 +0900 (KST)
Received: from dpss52-OptiPlex-9020.. (unknown [109.105.118.52]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240920055056epsmtip2845f883041306867f49f0c759215f8e3~23d8Aaj2h2898528985epsmtip2F;
	Fri, 20 Sep 2024 05:50:56 +0000 (GMT)
From: "j.xia" <j.xia@samsung.com>
To: dsterba@suse.cz
Cc: clm@fb.com, dsterba@suse.com, j.xia@samsung.com, josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org
Subject: Re: Re: [PATCH] fs/btrfs: Pass write-hint for buffered IO
Date: Fri, 20 Sep 2024 13:52:08 +0800
Message-Id: <20240920055208.29635-1-j.xia@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240919184552.GB13599@suse.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHJsWRmVeSWpSXmKPExsWy7bCmhu5a/rdpBvef8VlM6p/BbnHhRyOT
	xeLf31ksbh7YyWSxc9ladouPe1YzWfx5aGhx9P9bNotLj1ewW5yd8IHVgctjYvM7do++LasY
	PdZvucricWbBEXaPCZs3snp83iQXwBaVbZORmpiSWqSQmpecn5KZl26r5B0c7xxvamZgqGto
	aWGupJCXmJtqq+TiE6DrlpkDdJmSQlliTilQKCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8Ck
	QK84Mbe4NC9dLy+1xMrQwMDIFKgwITvj/4c3TAW7OSpeXznL2sD4hK2LkYNDQsBEYsWL+C5G
	Tg4hgd2MEuuX8kPYnxglDs0X62LkArK/MUrMmD6fCSQBUv94ykZmiKK9jBLPZudCFH1llJj0
	+AQbSIJNQFHi3Mw/7CC2iICwxIK1p5lAljELZEj8+JkJEhYWcJI493sm2EwWAVWJPVdnsoDY
	vAJmEmcW7IfaJS+x/+BZZpBWTgFdiYmb/SFKBCVOznwCVs4MVNK8dTYzyAkSAp0cEj37lzBD
	9LpI9Ox+zA5hC0u8Or4FypaSeNnfBmUXSzRPfc0C0dzAKNFw+hcjRMJaYtv6dVA3a0qs36UP
	EZaVmHpqHRPEYj6J3t9PoO7kldgx7wnczY/WzmCGhK2oxN9VkhBhD4lT/y4wQ4IKaNX6iZdZ
	JjAqzELyzywk/8xC2LyAkXkVo2RqQXFuemqxaYFRXmo5PIKT83M3MYITqpbXDsaHDz7oHWJk
	4mA8xCjBwawkwiv+4WWaEG9KYmVValF+fFFpTmrxIUZTYHhPZJYSTc4HpvS8knhDE0sDEzMz
	MxNLYzNDJXHe161zU4QE0hNLUrNTUwtSi2D6mDg4pRqY+jP87A6YzBLe8V7BU0GxtNrRgKlJ
	qP2X+8I2voIFt+d2FH+fYJu0WPahZ7ILz6Lm3azinDvv7w3muHtwl/HSeTHZZxT4Xhjm9/34
	XqnUIphlaL9BU9pu7+HCrtXLDp5YobD4/eUV74o747YniK4TNwwrX1hyIefR+a9tK3k0mDOj
	uopKs+Z+Csrx+NT5sO5Ru/zpzGuWhkGT5X32vLt27U/Fi/WyiQfWcdW0CqXm2762iru6V8Ki
	JXvnsdCrob3s9/uPuP9aWa11Ynf0tKO/9695wufEYL1JId9+1r+SogqWjRkHU3IC317Y8J7t
	6oHsd/9Wa0359uhzvZyvycyL/9R2eiyK/Onwd33aroYvSizFGYmGWsxFxYkAeh6iSzEEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBLMWRmVeSWpSXmKPExsWy7bCSvK4T79s0g01bBC0m9c9gt7jwo5HJ
	YvHv7ywWNw/sZLLYuWwtu8XHPauZLP48NLQ4+v8tm8WlxyvYLc5O+MDqwOUxsfkdu0ffllWM
	Huu3XGXxOLPgCLvHhM0bWT0+b5ILYIvisklJzcksSy3St0vgyvj/4Q1TwW6OitdXzrI2MD5h
	62Lk5JAQMJF4PGUjcxcjF4eQwG5GiSk7HjNCJEQlrpw9DFUkLLHy33N2iKLPjBKrnh9gAUmw
	CShKnJv5hx3EFgEqWrD2NFMXIwcHs0CexOVn+iBhYQEniXO/ZzKB2CwCqhJ7rs4Ea+UVMJM4
	s2A/E8R8eYn9B88yg7RyCuhKTNzsDxIWEtCROHb6LVS5oMTJmU/AbGag8uats5knMArMQpKa
	hSS1gJFpFaNkakFxbnpusWGBUV5quV5xYm5xaV66XnJ+7iZGcOBrae1g3LPqg94hRiYOxkOM
	EhzMSiK84h9epgnxpiRWVqUW5ccXleakFh9ilOZgURLn/fa6N0VIID2xJDU7NbUgtQgmy8TB
	KdXAFJcqwp4ptem8r2TtrdPq3g+ucs2wSei7tIXd8YnqxZxHlxe5qB40yFyb0at0Ybrt4a/r
	ndecNNMwW3iE8871gM+WIWt8dc8UHTod53LD4V7qdaPPUgfabz/k/XasY+qP8+qTPx7elJO6
	Vr9Qa2WBgOay36Whb3eXGwRv0pB7cvXJestK/4P3999ZEJL4a+/22b67j+86MC/uc035/8kX
	fp7Sys4/3StW2b1h3h5j9Uktr5dG2a16V+a1NHe6Wqzjf+lTRoErZ/zyOVNhzbvM+Y3g10YH
	dze7JkddvscRL/fty3O7+d/s5ccnd63PB9+dnflE4uNhFYmsWQ/i3uxRbk5LWLWeOfVhwxWt
	84Lfbm9RYinOSDTUYi4qTgQAVCWCCusCAAA=
X-CMS-MailID: 20240920055058epcas5p29d7d9fac2d1c71c33eb51ee02d70cf8b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240920055058epcas5p29d7d9fac2d1c71c33eb51ee02d70cf8b
References: <20240919184552.GB13599@suse.cz>
	<CGME20240920055058epcas5p29d7d9fac2d1c71c33eb51ee02d70cf8b@epcas5p2.samsung.com>

> On Tue, Sep 03, 2024 at 01:40:12PM +0800, j.xia wrote:
> > Commit 449813515d3e ("block, fs: Restore the per-bio/request data
> > lifetime fields") restored write-hint support in btrfs. But that is
> > applicable only for direct IO. This patch supports passing
> > write-hint for buffered IO from btrfs file system to block layer
> > by filling bi_write_hint of struct bio in alloc_new_bio().
> 
> What's the status of the write hints? The commit chain is revert,
  
  "enum rw_hint" include/linux/rw_hint.h defines the status.

> removal and mentioning that NVMe does not make use of the write hint so
> what hardware is using it?

  New NVMe Flexible Data Placement (FDP) SSD (TP4146) is able to 
  use hint to place data in different streams. 
  The related patch is
  Link: https://lore.kernel.org/all/20240910150200.6589-6-joshi.k@samsung.com

> 
> The patch is probably ok as it passes the information from inode to bio,
> otherwise btrfs does not make any use of it, we have heuristics around
> extent size, not the expected write lifetime expectancy.

