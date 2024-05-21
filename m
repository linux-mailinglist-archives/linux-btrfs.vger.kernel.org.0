Return-Path: <linux-btrfs+bounces-5144-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5588CA957
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2024 09:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A2BF1C21301
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2024 07:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70AC5381B;
	Tue, 21 May 2024 07:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="OId7RAG3";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="jHp2KUPJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135D253E3B
	for <linux-btrfs@vger.kernel.org>; Tue, 21 May 2024 07:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716277824; cv=fail; b=kNaHO1TWkTOiL5W+EQbcE0zHG0lZ1Dianq9O38otG9OCX0L7Aw0lLjWf6xBkGh51eh1dhXirexlQzeZStWhKwOtjTj9eNjc143oxHVj3RnpUO5/H8ZtCVIVvnICiyMQqdAZS+LOBhk4RkQygraCueSEAbxmOSfDeX48y/AeZMMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716277824; c=relaxed/simple;
	bh=7bRAbVe/l6Uw8PCvihToLPfjJX7xhqfRXNAe4M33dtI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VyNcopMdPELKfQyvxYMZHcYrn7vLbn1zjAPkbQPBbvzvCsmaRY/g4viQcVa+TmmIvcUIIZQ5P0Z/cNR5M9iwKbLNfjZMQ1jH9xL4h/uQOAVoUYdzcWuPMteJK/Ql4r8HcSMbC73M4nqMo9ak80/0qpz4fsYEOzLqAinuuuj6+7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=OId7RAG3; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=jHp2KUPJ; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1716277823; x=1747813823;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=7bRAbVe/l6Uw8PCvihToLPfjJX7xhqfRXNAe4M33dtI=;
  b=OId7RAG3ZTIuJaXSzZFNP8BVlJxYhUdu8fhO3PYH6/MOJAhpzca2pDcZ
   +GHVMPk1Vq0Em7/9oM7Q/oEMz9Y7nyhTf9rqCwbq9X37+ktR3x9m38nsa
   XACvNxvZjjptejI0uHQRqClCAP3uq/SX5YOkOGDetrxaji7s+ADDG+c0r
   4SGSmomOEhgeW8cst1k6hXUdEhRrHFiwcD5og/Bc1mU4upP5YSp1SGbVX
   XymHjtCfo+3nTy4uhxrx0BI3IAY94d2S1JN2EsSttmp9wTcV9EAksNzD8
   6ey/5tOLpmSX3mBxZGL49v4Y03EHYwfHUI8UH1GlSRFay9PlVDwy0/jBe
   A==;
X-CSE-ConnectionGUID: NZ4b28SZT9eVPvE6RyWDGQ==
X-CSE-MsgGUID: 5JUK8oTEQ5uNDVXxQRygxQ==
X-IronPort-AV: E=Sophos;i="6.08,177,1712592000"; 
   d="scan'208";a="16569321"
Received: from mail-sn1nam02lp2040.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.40])
  by ob1.hgst.iphmx.com with ESMTP; 21 May 2024 15:50:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IcPpu1p+tyNjdijhzw9hkPqokNURMbR5bFLxyVLGcRFfNlQ9IHWxAZWAjn7orwSDTxgNep0Z2v9uwKmoqP9LX2CpQy36PB9osN6k4Ycxt8mMMLZbUX5OFAn+7AsqE88PF4h4uwyHNsPKq1kvc6FGEAQ2fnEe9JeVhKzQzTcNIEAbGaKZXusw1sCVAFCySp2KjzHl6sBe4tfZbg4zZBbMAOgN2zj+hMi5pbDD9qMr2pcxzHHSK6/QvF7izZqW1z0sXvwAmAQpY4MSo9Nu729ydJyfDg5IScmi/6c9bPQzaheGc178t47ltgbQz1zNjcHWW7dti6guvfjhyrCZg2xvfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TkEPehAA/MsK4nQ3FdYSQk6YMcvGruQ3qIf8/8O376Y=;
 b=HEguMgENK7C2H+E+5XShv/kiDHnksq8iMhqW7QY+JjeSF0ITK0JRd4O7dydvJP8V91TFw5XEbbgpowVYMHnuL45SZIbRwcKLt2CtkwB9jmWK0cm0L2lq8NTesnWqCxpbea90v7gvdjzsQZIdU3t4KzxE56Ppro6//sruFYpENqW0lq0jpYGRR2ndbRiPHM5rpsNxz5N5kMZnOru5pbV3tGPE6Ror5N/bVQNDTLeHJ8Skh9gfAOVpiaqtQkx90YQeY5QqlzCpj2k2PQue/e4kLNPrNlBvInsU9rLmrFNIf7CO3NwY6PqeyzjRx8TcCaGT4YDpDKqc7SEt26eLY2Us+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TkEPehAA/MsK4nQ3FdYSQk6YMcvGruQ3qIf8/8O376Y=;
 b=jHp2KUPJwoGxkPYJxFXfL9ve+zETGi2fMaDMDhrPg9DEPqVHqpI+mDgGU0ywYgo0C1eLv5dWZnIzgGxOTTVJhnb8lcCraM28fBlhjeDZHrvHrI25Wz6qTghHgsEiiGe7h54DBRMUuMCGsXNF4EdIhdQjlLm4VKfCjVOox/0b4hg=
Received: from DM8PR04MB7765.namprd04.prod.outlook.com (2603:10b6:8:36::14) by
 BL3PR04MB8139.namprd04.prod.outlook.com (2603:10b6:208:34a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 21 May
 2024 07:50:20 +0000
Received: from DM8PR04MB7765.namprd04.prod.outlook.com
 ([fe80::8bb1:648b:dc0a:8540]) by DM8PR04MB7765.namprd04.prod.outlook.com
 ([fe80::8bb1:648b:dc0a:8540%3]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 07:50:20 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Qu Wenruo <wqu@suse.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, Johannes
 Thumshirn <Johannes.Thumshirn@wdc.com>, "josef@toxicpanda.com"
	<josef@toxicpanda.com>
Subject: Re: [PATCH v5 2/5] btrfs: subpage: introduce helpers to handle
 subpage delalloc locking
Thread-Topic: [PATCH v5 2/5] btrfs: subpage: introduce helpers to handle
 subpage delalloc locking
Thread-Index: AQHaqOFrc0NFEt+V9UK0P8ViuQm777GhVUqA
Date: Tue, 21 May 2024 07:50:20 +0000
Message-ID: <5faun6sbhn3x37b2kwudtnuumquuiyi4oyferavknmxgoofwgk@tubvkvthpwog>
References: <cover.1716008374.git.wqu@suse.com>
 <996c0c3b0807f46f7ae722541e6a90c87b7d3e58.1716008374.git.wqu@suse.com>
In-Reply-To:
 <996c0c3b0807f46f7ae722541e6a90c87b7d3e58.1716008374.git.wqu@suse.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB7765:EE_|BL3PR04MB8139:EE_
x-ms-office365-filtering-correlation-id: cf1b94fe-300c-4619-fbd1-08dc796aa9bc
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?GNiHsqXsBCEtI1/VqFg2OTNl6iTRX7yLRMdTyK6RqfmrLoufolzbyjmsZM07?=
 =?us-ascii?Q?QeDDCLIfTrSiPahJD4yFVGd4bkAmeaJzV+XcVGoxo4zdbVXgZtP8GX/Poqrq?=
 =?us-ascii?Q?pkgfoeHmWj9GbDTAK3yz+c5LpkZCnmrDdGCrChOfyTZRfZz/cAzzJvX6ks/K?=
 =?us-ascii?Q?02ZuY1u5u1ywoAELPyiPmU/dBaQaWZhBYgto9kq1yqBSdZamVMVlaQl/maUW?=
 =?us-ascii?Q?TBR6veQoU/K+025xq0GJ3G/9hwxHrYB4ZsYRNnJCwWd5fFq46syt7Iv4JZ14?=
 =?us-ascii?Q?mf3gtyP86mUMPuAha5PyXRgdJhuneIfWOqqdCTbFC/DJZYwHoZYRqv9szPFM?=
 =?us-ascii?Q?vZze/tYrVwtLzcsn78RSrUZR9ZsuPR9sYvQ+EHyOs3m6sjfqu6dklA714foJ?=
 =?us-ascii?Q?aWLvfs0AcWlH3slg9ReIMhbUhRUmTqXYy/wNAGiZTQMP+WZ6XqZ8zTS7PF0s?=
 =?us-ascii?Q?gXimkAc6zr75NU40MKIYVRYnczuOq9ELtIET/+wKsIpZGjJ43LYNG/S/BP//?=
 =?us-ascii?Q?ZQSZIkOHHkmcQgQPz1KordDdXcCMwq80TxqXQ/L2+kjZMMafOQb3IeWoYdv8?=
 =?us-ascii?Q?irke82uts4UVhzuAZZfKLXz65QsjzqATW1FViqIh6ds7zl2T+3f21ZO8VQuu?=
 =?us-ascii?Q?0LKMjfb0baTQlB2cum0eQy4D+xQALTGYIy32ZEETHuQ3RQNSfgvsBypcVwq4?=
 =?us-ascii?Q?9eeEHkBBxsPcIg/jB+YTWnZcNgnoeBM1oKmpZs9MrUpi0SwbhzO8R+/rBcSX?=
 =?us-ascii?Q?kMeWvUpzFzAC1Qn+pmTwLIW9yhtCE7mPfEKIbyxOnDF2TkR8bStzlxd6JkMG?=
 =?us-ascii?Q?kBMo+LKqa4Yz4JkHCR7/0hTiyT2kJpib4oEWmt7fa+En/9IoQbpQ9+L0nVYt?=
 =?us-ascii?Q?PZAywtnRNkkWcWT9oWev0jZ2bu+jbX/XZGAfwjAsGXEnW5d659GIqDNDcINO?=
 =?us-ascii?Q?WmGfcqVvEWF6IN2o7SlFThWcdCWzX9Uk0b6HP2SiUKmstugB2ZemArg6uWAd?=
 =?us-ascii?Q?P+msFzkQxXc6WfunWyK4w8aXeTy3/R6hkzK6k4gsZ2uhDuwPm4tHc7Y/QitC?=
 =?us-ascii?Q?amTxv00lSiwk1kHZMwLPUjeN36V+MNcyQiZAT8l6XEjgU8l8vCNwkjZha4JN?=
 =?us-ascii?Q?FnfL1nivK0eB2q2IU3BFKMXPfDEDepU8Xqct8aFCqWnvt3zd6OKpJehpfq6B?=
 =?us-ascii?Q?sssC4KqKHJ3dfG8SVXiHFC/UJP5WZyOzVACq0Gui3bkd1DMAjODliFoIH7+7?=
 =?us-ascii?Q?ar6Wwk1r5vhPqzNw7miM0Zb0ZbUlbC9smOFlE9LjwFKrjjBd3dyGTa24ZTcV?=
 =?us-ascii?Q?mSPmerCvu/kxO6ldYAdmaYfR4+HG6bppxs5zn/2EvKTCkA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB7765.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?3tbi0ne0b0VYSFtI3RG0ZXVOA27Ok2dv9tykCx02OVUK8snlXiAq+UH9riVa?=
 =?us-ascii?Q?fzYISluQFOAAf/7h6qfV6hJuw5RjXA8sON65N/EvBAXoPftA6Q4AWqdZ3TdW?=
 =?us-ascii?Q?JiCIeTE8t7hOY6KDSb1RzLOPgP3yZaJLPmlbgGhN92DKnvIkDp6jpTXXCI3S?=
 =?us-ascii?Q?XVU5klrmZRakXWH/gM8ZASY2g58OuHI8x+7n6xRo9Vw79Dd23njw3gHxoa6B?=
 =?us-ascii?Q?NutpIpz+KEZpQd77warU75crgSvrRAmivdcS9NZgToEmWtvIVN4KScWLgvQa?=
 =?us-ascii?Q?ukZliyufIZ6mO4SSi6GvGnM7fSLB+addOlKmn3XZ9wwctw3YUilDhTwjN4SW?=
 =?us-ascii?Q?H274q8CIRb2wOiBFys87jVlv4+na9gdiVKoVBANS+XjYsANbHw91SHuvoN6i?=
 =?us-ascii?Q?0ubkK8UTjSLiqqBn7ehXV8lTgSDCPVjcnmdsTHYVvpeHYaiVNKhBnxsmu4EH?=
 =?us-ascii?Q?maIR0WadRSp9vsv32emQYrOghMDDyTBwd7nlpdnzSPE87K5Mq+Omt19H6f9U?=
 =?us-ascii?Q?rpoiwXTZu7zX/HMa0bXZf21Ba7xZaoOoZo1SN5BMyfCnAgJ60EzuJ/K90/Sd?=
 =?us-ascii?Q?CzEVOuXS6noYn3TYAwNuWQDjyewHkBWLZfpsungWLhQDeGuzIGsTQlVCV3i7?=
 =?us-ascii?Q?zWi+XVkNt1QUX+niopKoAM5rTAMwoLdQI2fze1JYGIyoX90hMEbvBLe5HmXk?=
 =?us-ascii?Q?KH+H1FTyRFTJfSp38MWGHAbttAXo+DHobqgD07+YH2GHruke+1SXmUBwLSLr?=
 =?us-ascii?Q?S04rCVRcrdygHU2LSCT7/M2Oe2RBuAUX71R9itEfJp7Q7R/xJ9pJynG4eoUj?=
 =?us-ascii?Q?BXWe2P6Ce4fqrUr6rahXMXAcTL5PrLCkG2riuJjGAbY9tB/fD5nX0Noy0XoW?=
 =?us-ascii?Q?0QDQ+DcQHnbmgfOjiSUsswQOqnysRZrItUVtu/puHwVT9ISPJWar/GIVgOSe?=
 =?us-ascii?Q?Yf+BNVbvTh2sNkOladwYdVkJDDLbrgmbz0x74/8hvU/bYWEKzNfzOMOd+wCh?=
 =?us-ascii?Q?qNY0q3Vq+CRUp8w1PZyixTVpCgFeGp8NCfIWVdnb4IFKJtVOF7vlb1QgOa1A?=
 =?us-ascii?Q?0zKAquZ+c40p6RGaWpCBbfxvsAnlfBzeWUgHMdmMjv9oCg2sWhrq1myJFwMR?=
 =?us-ascii?Q?itBGh/rHI2PKWyeWWGSEnBPCHoSRx1avGtZHW8AIiARtzClUnSorM2EsuB4e?=
 =?us-ascii?Q?S4HSSCZ66hN58zmJKvbxyWGzB6R2dYIDgTiN9yjVmfVu/gaNDpVhr79MSy0e?=
 =?us-ascii?Q?ivAjz+eDnGcyFmJIZM+pc4etRRm9xSHz3BBp+3Bo7C+ldDCZlCUp0WbAKbmK?=
 =?us-ascii?Q?pUhoeqLeku2AbTzam6EFPT9bCaxV649YWlFMKT8QrB6e7GonbsQCrVJXMoLK?=
 =?us-ascii?Q?GkUFHTcdCrG/zZUU2Bte1XKk4LOJ/NPLbG0OusxqBMK/6rt1akF0zINNEvtT?=
 =?us-ascii?Q?PLjveRE0EOq+xakqj+4CkzfRQBF7iWEYT0k0sZqrpXsgJONa9QlvURiLuH93?=
 =?us-ascii?Q?a/HMegzxiGYPsxH2fJGaa6JFUXgDqkC+C0MSit1q4UAEa5FHpj5IRPN7HXsv?=
 =?us-ascii?Q?NVvLYvtYcln5nTsWbXYkQvDbCFJDE+ZFpd/BlI4I30mUFbXvNzlwLdn3cLBa?=
 =?us-ascii?Q?9Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <882CE325A4393E43B5A2831346C2C44E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	E9z7tdD1FSIK3ynpvrGf7vOS8QebI0Pm8RY/jkvsUhlaQno7cQ1zspWoufTbec2p2aZjobZAnWD+eN3ti6e7nfs0JJ+94XnM/sTSZajs/stT5WXS/ZfOmgxt+zrGmcdREQkP6PUZszFR5iymWI8uwEP7paSw+aonB05XrpSrRGDjYi4fWPoj6N5yElqgmJfcQrsed9UHB2/0h6derV/dz6tpRkYXZPPH1mBDkhU2Ixzwuca2q7YAnWj/NiYJR4C7RlWc8UEQ/sQ1x6WIMdNiETR92zaJtavNs+wP7KFH8MQKLPMgICGl1ouWHOTIPIlkRaE/ju1Tyyl02Thg5BkTAJihQVteIDb43NiEVwzrP6H0/ohGKdNe7EWPtLNGv8VjilQYwP7Eb9T/MmKUNUyubN3GzXVj5/PGWNWOUNVXNk5KSQ3+IS8fqEaiQpF3CWLQ0yNdVGx+JOhmrP/5xtCmvYDXEDm8U67DUpG6+SW3SEJTy9ichCgMsupSB4Yoe//diWNDFlGECQ1VZD6FcSWFnntAArIivBAPLesRbFKI+vCZJU9Z+yoh+1s6tytc+ph3FAGw2nBbCpDJCmdejQMEuqCKCfKlqul9dmWPMLWHBGwA/5LjrjAXXc+7Qug71b3L
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB7765.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf1b94fe-300c-4619-fbd1-08dc796aa9bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2024 07:50:20.0977
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g82W/S7CvHvuVUyvgl7KYpjlfEZhUE/wU76oP630tlUGJAFB+ai2H/Gy6Enuzfl2vheIcHoI+/IhyDZRWYUOZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR04MB8139

On Sat, May 18, 2024 at 02:37:40PM GMT, Qu Wenruo wrote:
> Three new helpers are introduced for the incoming subpage delalloc lockin=
g
> change.
>=20
> - btrfs_folio_set_writer_lock()
>   This is to mark specified range with subpage specific writer lock.
>   After calling this, the subpage range can be proper unlocked by
>   btrfs_folio_end_writer_lock()
>=20
> - btrfs_subpage_find_writer_locked()
>   This is to find the writer locked subpage range in a page.
>   With the help of btrfs_folio_set_writer_lock(), it can allow us to
>   record and find previously locked subpage range without extra memory
>   allocation.
>=20
> - btrfs_folio_end_all_writers()
>   This is for the locked_page of __extent_writepage(), as there may be
>   multiple subpage delalloc ranges locked.
>=20
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---

There are some nits inlined below, basically it looks good.

Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>

>  fs/btrfs/subpage.c | 116 +++++++++++++++++++++++++++++++++++++++++++++
>  fs/btrfs/subpage.h |   7 +++
>  2 files changed, 123 insertions(+)
>=20
> diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
> index 183b32f51f51..3c957d03324e 100644
> --- a/fs/btrfs/subpage.c
> +++ b/fs/btrfs/subpage.c
> @@ -775,6 +775,122 @@ void btrfs_folio_unlock_writer(struct btrfs_fs_info=
 *fs_info,
>  	btrfs_folio_end_writer_lock(fs_info, folio, start, len);
>  }
> =20
> +/*
> + * This is for folio already locked by plain lock_page()/folio_lock(), w=
hich
> + * doesn't have any subpage awareness.
> + *
> + * This would populate the involved subpage ranges so that subpage helpe=
rs can
> + * properly unlock them.
> + */
> +void btrfs_folio_set_writer_lock(const struct btrfs_fs_info *fs_info,
> +				 struct folio *folio, u64 start, u32 len)
> +{
> +	struct btrfs_subpage *subpage;
> +	unsigned long flags;
> +	int start_bit;
> +	int nbits;

May want to use unsigned int for a consistency...

> +	int ret;
> +
> +	ASSERT(folio_test_locked(folio));
> +	if (unlikely(!fs_info) || !btrfs_is_subpage(fs_info, folio->mapping))
> +		return;
> +
> +	subpage =3D folio_get_private(folio);
> +	start_bit =3D subpage_calc_start_bit(fs_info, folio, locked, start, len=
);
> +	nbits =3D len >> fs_info->sectorsize_bits;
> +	spin_lock_irqsave(&subpage->lock, flags);
> +	/* Target range should not yet be locked. */
> +	ASSERT(bitmap_test_range_all_zero(subpage->bitmaps, start_bit, nbits));
> +	bitmap_set(subpage->bitmaps, start_bit, nbits);
> +	ret =3D atomic_add_return(nbits, &subpage->writers);
> +	ASSERT(ret <=3D fs_info->subpage_info->bitmap_nr_bits);
> +	spin_unlock_irqrestore(&subpage->lock, flags);
> +}
> +
> +/*
> + * Find any subpage writer locked range inside @folio, starting at file =
offset
> + * @search_start.
> + * The caller should ensure the folio is locked.
> + *
> + * Return true and update @found_start_ret and @found_len_ret to the fir=
st
> + * writer locked range.
> + * Return false if there is no writer locked range.
> + */
> +bool btrfs_subpage_find_writer_locked(const struct btrfs_fs_info *fs_inf=
o,
> +				      struct folio *folio, u64 search_start,
> +				      u64 *found_start_ret, u32 *found_len_ret)
> +{
> +	struct btrfs_subpage_info *subpage_info =3D fs_info->subpage_info;
> +	struct btrfs_subpage *subpage =3D folio_get_private(folio);
> +	const int len =3D PAGE_SIZE - offset_in_page(search_start);
> +	const int start_bit =3D subpage_calc_start_bit(fs_info, folio, locked,
> +						     search_start, len);
> +	const int locked_bitmap_start =3D subpage_info->locked_offset;
> +	const int locked_bitmap_end =3D locked_bitmap_start +
> +				      subpage_info->bitmap_nr_bits;
> +	unsigned long flags;
> +	int first_zero;
> +	int first_set;
> +	bool found =3D false;
> +
> +	ASSERT(folio_test_locked(folio));
> +	spin_lock_irqsave(&subpage->lock, flags);
> +	first_set =3D find_next_bit(subpage->bitmaps, locked_bitmap_end,
> +				  start_bit);
> +	if (first_set >=3D locked_bitmap_end)
> +		goto out;
> +
> +	found =3D true;
> +	*found_start_ret =3D folio_pos(folio) +
> +		((first_set - locked_bitmap_start) << fs_info->sectorsize_bits);

It's a bit fearful to see an "int" value is shifted and added into u64
value. But, I guess sectorsize is within 32-bit range, right?

> +
> +	first_zero =3D find_next_zero_bit(subpage->bitmaps,
> +					locked_bitmap_end, first_set);
> +	*found_len_ret =3D (first_zero - first_set) << fs_info->sectorsize_bits=
;
> +out:
> +	spin_unlock_irqrestore(&subpage->lock, flags);
> +	return found;
> +}
> +
> +/*
> + * Unlike btrfs_folio_end_writer_lock() which unlock a specified subpage=
 range,
> + * this would end all writer locked ranges of a page.
> + *
> + * This is for the locked page of __extent_writepage(), as the locked pa=
ge
> + * can contain several locked subpage ranges.
> + */
> +void btrfs_folio_end_all_writers(const struct btrfs_fs_info *fs_info,
> +				 struct folio *folio)
> +{
> +	u64 folio_start =3D folio_pos(folio);
> +	u64 cur =3D folio_start;
> +
> +	ASSERT(folio_test_locked(folio));
> +	if (!btrfs_is_subpage(fs_info, folio->mapping)) {
> +		folio_unlock(folio);
> +		return;
> +	}
> +
> +	while (cur < folio_start + PAGE_SIZE) {
> +		u64 found_start;
> +		u32 found_len;
> +		bool found;
> +		bool last;
> +
> +		found =3D btrfs_subpage_find_writer_locked(fs_info, folio, cur,
> +							 &found_start, &found_len);
> +		if (!found)
> +			break;
> +		last =3D btrfs_subpage_end_and_test_writer(fs_info, folio,
> +							 found_start, found_len);
> +		if (last) {
> +			folio_unlock(folio);
> +			break;
> +		}
> +		cur =3D found_start + found_len;
> +	}
> +}
> +
>  #define GET_SUBPAGE_BITMAP(subpage, subpage_info, name, dst)		\
>  	bitmap_cut(dst, subpage->bitmaps, 0,				\
>  		   subpage_info->name##_offset, subpage_info->bitmap_nr_bits)
> diff --git a/fs/btrfs/subpage.h b/fs/btrfs/subpage.h
> index 4b363d9453af..9f19850d59f2 100644
> --- a/fs/btrfs/subpage.h
> +++ b/fs/btrfs/subpage.h
> @@ -112,6 +112,13 @@ int btrfs_folio_start_writer_lock(const struct btrfs=
_fs_info *fs_info,
>  				  struct folio *folio, u64 start, u32 len);
>  void btrfs_folio_end_writer_lock(const struct btrfs_fs_info *fs_info,
>  				 struct folio *folio, u64 start, u32 len);
> +void btrfs_folio_set_writer_lock(const struct btrfs_fs_info *fs_info,
> +				 struct folio *folio, u64 start, u32 len);
> +bool btrfs_subpage_find_writer_locked(const struct btrfs_fs_info *fs_inf=
o,
> +				      struct folio *folio, u64 search_start,
> +				      u64 *found_start_ret, u32 *found_len_ret);
> +void btrfs_folio_end_all_writers(const struct btrfs_fs_info *fs_info,
> +				 struct folio *folio);
> =20
>  /*
>   * Template for subpage related operations.
> --=20
> 2.45.0
> =

