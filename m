Return-Path: <linux-btrfs+bounces-5142-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5D98CA8A0
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2024 09:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8566B282B39
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2024 07:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711CF4D9EF;
	Tue, 21 May 2024 07:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FnN7OMAM";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="JkmpGMrb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9474CE04
	for <linux-btrfs@vger.kernel.org>; Tue, 21 May 2024 07:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716275618; cv=fail; b=hfflxacH8Ey9NNKmnOX7rc2Z580J3NPYjBX+4emUePJOB7tF8eRltAZBc3qLjxFAocdqfZezSrLS0y8mfkIBmuEFzcHh8Y9FW43B9aZcj53pgucU3ZwmXhOb1EKCtENj0MVJS538NShBqma7T1ynKyydnqwEYaG3hDxT006+zDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716275618; c=relaxed/simple;
	bh=JZ6nk8WyQpUITN+2W7Bem0UPJ3ZAnkzW59G478haQek=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=C9C+dzrcQIizE+Q1tTqpq9aAn4d/Qu9D9kB5BpDoJNK5QxJvzdkdYIItI2lbulmfGrXdBZAk6+SGDK7lNMU09K7L4kYwY0groDBrunkp3+f7tIm8Z1fGXPyPgyjuRvBGOEND0mDZ99diVZdLxT1K/Bm+B0nRwpcYxziqD2wCjgI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=FnN7OMAM; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=JkmpGMrb; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1716275617; x=1747811617;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=JZ6nk8WyQpUITN+2W7Bem0UPJ3ZAnkzW59G478haQek=;
  b=FnN7OMAMSGACJdi4PPF9H3+aY4jrQwyPokM3RhLrpV70M0dPMCVFc3Ys
   w2MCOEASINxPrc2aE8ccJ8QtChSit+GCYxW7zQIXg7wj6SaUUx8xYEgGl
   brBcruTfytPOrRynKGq6eYmhWqEdynJtxqCrVyzBOA8fNmV8TCkjCs7Hf
   oyaHx1bjSwwuZK2kyP64I6wOwgIv/Opptqs1kkZ4VsxIhzOFg1iKT6YOi
   /WwzWqGR/wS2OYQdROCHXlTqZWnt7u2eKCvvBICaPwBzmuUdoaTkdE5GX
   zOYcxPPCBg/fa6PBZn7FG1GiW8L6vlr0+k+qXNNyy567sFoEyTU9PIC6d
   g==;
X-CSE-ConnectionGUID: QM1AIGGHSd+f0sVDiru9DA==
X-CSE-MsgGUID: miJOfr19T+G41Ft41NgTSQ==
X-IronPort-AV: E=Sophos;i="6.08,177,1712592000"; 
   d="scan'208";a="16564512"
Received: from mail-dm6nam12lp2169.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.169])
  by ob1.hgst.iphmx.com with ESMTP; 21 May 2024 15:13:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e3qhU4GBu+Up5j1TtwSkhXR5Y5NeXsJ4xgDwd/beDDTotfxcahU6SthQtyMxL6LSAOtKry8YQnqT1vglKjNUYb0ylq7IilR5L2UFcCZycPfrmEKMoKPktYdbj85mYlVhJ5/SOp4Q1aZqaVLdyS8iKklAYhZaFkvhDWGDkKymbZU7/moiZOhQjJgUZMNis2u8VaZ4cl9A/J0HGRK78gtuEdz7FeQeaSmEwj0nz6GImd8our8iDM1kU8R3ZPwK/NWGOIHfzY8kN+uM8znj3edkzuVJZY9QJIFbah01VuQaHmhkQQ1t8pmfV/MSdI6YwtWizi4qmNPo85WHHB/idpLhhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JZ6nk8WyQpUITN+2W7Bem0UPJ3ZAnkzW59G478haQek=;
 b=g0/7bkYLszOKmc83S9qAnHcXowiS1MekPMYn/yCRr452VrnA/AhN6ZtnT20F06v2eXsb6QD8KeBVBEzK0ZwpWvXNoZBb03CbhzE6eCxJb/yshTiGEJSxhul3f7hU3WktKcMHji8ydxXD5huw4uwo8vymCwPzg61b8tm8N0QpwsTOjLm+ZZOd7nnQ68iBjdiUW3GxcvVu5wZCrvhP8XtrX5NkKu92Y1kLMuscwFH64hy4OGRyWspKjdNLM5RtMRIR5SQKErXH8bCc3pTI2lyZpPGQFY/IJ20xHrDW6vb28V+iEG1hC5l5Ts2+8YSRF58i8X7ctSMXXuXKjBpYaHHZ0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZ6nk8WyQpUITN+2W7Bem0UPJ3ZAnkzW59G478haQek=;
 b=JkmpGMrbRpa/ZNVKRaXQXqvX4N8aiTQhzfkObQROhLMT71ES/dOLanR0Ar/9Zrb20Tl0ILaQWf41o4a9u5wQTUwC+dk8ncrPRomQNXNpNeET138bJZK9m8vVuBUlpwtNjJ8k4Qfiea1+G21sgwkmd1YwtBJ4AgP6iLKmOWL/Pkc=
Received: from DM8PR04MB7765.namprd04.prod.outlook.com (2603:10b6:8:36::14) by
 CH0PR04MB8003.namprd04.prod.outlook.com (2603:10b6:610:fb::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.36; Tue, 21 May 2024 07:13:28 +0000
Received: from DM8PR04MB7765.namprd04.prod.outlook.com
 ([fe80::8bb1:648b:dc0a:8540]) by DM8PR04MB7765.namprd04.prod.outlook.com
 ([fe80::8bb1:648b:dc0a:8540%3]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 07:13:28 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Qu Wenruo <wqu@suse.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, Johannes
 Thumshirn <Johannes.Thumshirn@wdc.com>, "josef@toxicpanda.com"
	<josef@toxicpanda.com>
Subject: Re: [PATCH v5 5/5] btrfs: make extent_write_locked_range() to handle
 subpage writeback correctly
Thread-Topic: [PATCH v5 5/5] btrfs: make extent_write_locked_range() to handle
 subpage writeback correctly
Thread-Index: AQHaqOF12pg/D51OU0O1P9DXMrs2irGhSv2A
Date: Tue, 21 May 2024 07:13:28 +0000
Message-ID: <yfw2e64a7ihu5pd5piqnpaaurfs72t6ni5ehw4yat46d3uk6ml@qopf3y7cmr5c>
References: <cover.1716008374.git.wqu@suse.com>
 <cde3e15ca5b4a3a3a2df8749a7944243bcc29bd4.1716008374.git.wqu@suse.com>
In-Reply-To:
 <cde3e15ca5b4a3a3a2df8749a7944243bcc29bd4.1716008374.git.wqu@suse.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB7765:EE_|CH0PR04MB8003:EE_
x-ms-office365-filtering-correlation-id: 1669e38c-a040-4079-a9df-08dc79658391
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?N7BiLChBvr0Pvgnubf+lEvxdeRizVoOkD37m6CVNDphmVsnEfajuuSZwU5TW?=
 =?us-ascii?Q?kxlrlxQdif9BcQjYoi0SX92c+pyoou1L6jixxnFKMiqdy/0CP7bptsJY8JIc?=
 =?us-ascii?Q?x/HZ86lLeUuSH4bTQ/D5Jx8jLUFywScw20CIbmLzP6rcZaDBMG3ZJghiPJJw?=
 =?us-ascii?Q?l2nHW73h+5N2WZk0mKslfoO7E0CVth5MHgDc7Z7QW75wcX4PLjg1IWGDpGfM?=
 =?us-ascii?Q?163R/0ZoLLNsYWOM/JFShQiGNeJLBpiDUowXlBTHvLMISjIYjXm0n2X/YEfk?=
 =?us-ascii?Q?SemF98WyP0jL72nVtkX19Hb8hLTW7E0n89LC13b21Onx0Ay6xMXfhwKsmeo0?=
 =?us-ascii?Q?UHkzRBg2pCM/Fz2lBR4uPPO9eXUH0ntKM1jyLWX51gio3Zijy2A5QRvQpQL3?=
 =?us-ascii?Q?814fw1O2YswAVR0nzFtwUFvatt6fj7+0ZPXFwbYkUzHaQCTeIr2worhiX8KZ?=
 =?us-ascii?Q?W/wTOc881+ANoyb9lZnTsBjzkohU9kiQ3uE/I40tCDQdrnXu+sjPQQwcUM6u?=
 =?us-ascii?Q?X/MJrooMqJP49MT+8qxUKpgwQiWSJXtQjM6vT2OMT2p5TXpxhcyZfGS0uLP3?=
 =?us-ascii?Q?9AdRQKoV24iym3f+udTF5gf0EpGAtDmkT9o6frnHO6mSrH7M1zD3zlSP3uKV?=
 =?us-ascii?Q?cFl80Wpg6GoOfW+KDuZLine+rZtbhhCTWta/TujpNQ8zCBrCliDHKrKzQP2y?=
 =?us-ascii?Q?qXECoK4Wo1y4SpIX66uv9GybIft6m8ysX/unpgH8zRNJ/Y6kZYqmvm0UwNBW?=
 =?us-ascii?Q?BbJz9XqT3XDXQICKkQAgEIhRXGVQNEHMdo4pfhKLHUKfv7gZeQaITn0K9G2W?=
 =?us-ascii?Q?jIgRAWcDbq0E4gw7FYbchpv2SLjx/V47b5We4oKJnaxrwMpwj3zQs9KqHl7d?=
 =?us-ascii?Q?xENttb+r/yTpPP28E2iwvK0VjNOXYRa1c6Nx7Gv1Nngch53c0JAv1V4+E5FT?=
 =?us-ascii?Q?rRo6wrSYuGdBAup96Hynwq06qnThdAca2utGWyh4dO3iUVCV8/33urHhK4CQ?=
 =?us-ascii?Q?DP2S2nwSTfuowY3DD1vkEdqn0BooCAJDyWPCTQu7PB6XR7efwAT1+96jKgLz?=
 =?us-ascii?Q?8v1N3S50U5Q8JE3YB27zYFLqdcS/SwIY0lLYQ7nQoQadp727eFRNQzf+xXif?=
 =?us-ascii?Q?DwZ/5zTPNT52MWoD89dgz6TgPmnhYGvEtdcmseo8/DgIOnCIzhuOuYWM4sfI?=
 =?us-ascii?Q?KY4Z8cPiLx/90PSNSHZbNLeYP9cNyJIAYvKinsLUhyWOBHlslLFSLQJhYHzL?=
 =?us-ascii?Q?d3IrGsHLT4JbzPh2kYgBbGR0UyTgIZY6bNKPoHImGZaCumkV5b/I9SmXctJ5?=
 =?us-ascii?Q?j3QQ2e49XK5WLGjLqJNYEvfW2VC5cTogftnG6KerkVqgUw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB7765.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?IzSpoBaUZxK/rdyy1GVGYIe1wDtcSvqC6iOy5NNbu7kA2KloUTf5hoeBa3Vl?=
 =?us-ascii?Q?ynwPaJHh2Vssf9/2Zb95X+pePm9KadM9rHY5hpGI4ynGGtl3zdF8sN05+H9O?=
 =?us-ascii?Q?bXcVNQrvNXGtweaYmWNqiSyEi809z26Dr9/xjxpHjoDyuun+PYSmiyovUfPy?=
 =?us-ascii?Q?wX9IIbZmg6/Ms5DEEQUArHrmKYlJGJFLABa9UtR35c9jwLeLzHxfPWJD8QqR?=
 =?us-ascii?Q?upwnpeqb3VCdodk2+BFr5Z/5aaxDfAUDuVYztd3eVrgJwC81V0TZZcudguyR?=
 =?us-ascii?Q?f9r0xKeJnet1QVFz6Gkog28RbpmCnpdB2iN5liDGTAotu52re+/3Db+myh1r?=
 =?us-ascii?Q?L04Cgqj1blY1pO+FKBCKb1QLrfrH3oHFzs2ksroWBrVSz5OHaA7Q0BUIYZ01?=
 =?us-ascii?Q?7Djp5dXDCaoBK7jnVaT+xyEekvWdZVcOpJ/TECRlRoxLVFnIybFXuHNJxs+V?=
 =?us-ascii?Q?z5kYCI/a6pcZ6xrDnxo9HNri9n4n7DNWIImxcfE9G/r2ZDiQmNkRL3/zZ/pD?=
 =?us-ascii?Q?4zpfcpcDJc4mctFiPGrHaSN6eYeT+hyFh7Ue5RrTM+3HPOBPEPMc/fjSDjIy?=
 =?us-ascii?Q?G2H4aVWwN6aVqH+6BVFB88ewSoO2Td6wOWjJOp/znL9bUFdPpzHKvxb0mAUV?=
 =?us-ascii?Q?8SBuHOoWy7pY5HdYprB49EgLFaZZrpcCcwWJnicRedW0f5YlDagA4jKjmKjy?=
 =?us-ascii?Q?ZdK0L16kWax/QkLN8R36S3UtQXH3tC8vZoRNRy4Q+6Fa0KeqvuUnbYoM0tlw?=
 =?us-ascii?Q?qAMVjmWNIxk7i6TDZM6GzAASriQhTQOCAoPWGICh+3dt1yXRLZcPMZApWB45?=
 =?us-ascii?Q?mq9OJ6qN/xF1oUCtfJ3x7Cztilbltm1FtgJHYTUDxnKcRE7AVhVigenxZ2rN?=
 =?us-ascii?Q?08wR9dBul/x3fInBM9HXOzK5A8tBZD4Sxd3HmsNnkOmpa3vvieEwQSUByhho?=
 =?us-ascii?Q?L2e2o54t5AVO7xgJCsAo4MACO4vb4VM5/tXKgd6v9QrqJhu54iSY4U313kfB?=
 =?us-ascii?Q?mn+Rf34q20cCYEorMj7OAwgzN3F4wi89A8Lgrl2TomDzJj/ApWT5tiveio8k?=
 =?us-ascii?Q?J/Agz8aMKsNMhJxVTWBCwTx4cN2ADypcQEqi9DuGwwHGY+xaKAJyNlwb/zUD?=
 =?us-ascii?Q?vjQbF0U9MH9x3/jI3FpGRknwX3gK3iX0SEjSj2VT0jwDbWGHcaGvQC8CTom5?=
 =?us-ascii?Q?Z+wFefnR4SUjt5dlhosQjqTCJBszf04uZKGuMA0rxTKbRrZnaFrwj+9+Ub5Q?=
 =?us-ascii?Q?rAwnPSGOC9gjylixXn+ecAPc6wD0qo8sWvWOXtBaa8t8tDtQokhbSIrhGZjt?=
 =?us-ascii?Q?8ApP9oHjmDmv/Fmz7Twn3EHJJOWmqYaOMsOgkkYzNnbjUchkC0i6mbXCreI/?=
 =?us-ascii?Q?HCnjK0vukQfG89prZP4LFpwXqG8yQF1PxcRMP2UkRJCjiCHCXfk/03nSS4Tn?=
 =?us-ascii?Q?EhXyArWjX8ZJfnrgI83wX4Iv15nLhZMxXBOBQnN1oOWu0+wiBp93vLcKNPe+?=
 =?us-ascii?Q?wuhPw/KSkpUDUe3jF8wKYAejmUlNns/7eYgzoI9QR/beQ7jXqw8K8L9nzt9O?=
 =?us-ascii?Q?BQ+edjOQ8oSBUoQvhLNNTU9UX6sKAC3iLcBHV4r8Ab5Gr32HjIxy0Zx0SaHY?=
 =?us-ascii?Q?UA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8ADC7D6E5C7BF048BB1CB91C43DB28C9@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Rc0FR0QlH3/AxEUGjak2DeVConywVZ6KwJDZMjUIF0ZeAwyTbfrividfHpn+uBHfe8m1AhnfB4MLx1aviy//BCRcI0Ev4agd18Ygz1AI1x/0eh1lGv1PkJBB9W1PldO6LHenhA4+QYpNy0rrW/tbJCfKE44gccMBERAqqhcAu2VcsjkcqFatYwTHdbtV6rim58rH72gMXGH8vI1biA8AP6EOzRv4M3QIlkYECibQ/23x263/LE66CS7jBTLQtSuldGsc1JvG0+cVwDvJgQT9NtrmiBwWHaDuRBMOAB4mkYtXv7ulijKJturHhGLIMA8gt6MrqC/Q0UIQmuwB/Zm0rLldEzUrjsssB9Xf8DfOCN47LA/5l4JOh8Ycxc/u9V1U4XNqrIotEedV/GQCX+KvV/qKJsglEpJxWHdVsOjoSblvqd9D+vi+P4wUXsnVUhWC8ldcQpobBby74W7SXXQy9MN8ylN17YeikewmsyHhXPUXtj6hqwbgg6Ut+R/0WiiChg0NQG0TGDBkIwZgW+HJ8Qbm06RHEDo8SmXwU9PLmnxmX0VqaPOuuqoBo88UGiwH5kQjo3GnAnlX0RBpU1TNUtSdhLF9LoIpowYBy60wpCfVekdHponl6CujsnIFAxRZ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB7765.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1669e38c-a040-4079-a9df-08dc79658391
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2024 07:13:28.5710
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ios/gITKxasWBMTZWfqjDK/GtwUMDEUjQcIh+/WC+Vw2cEfpvhthcApkZuwtK3FD4YHtt64SiFCcJOBegyKxJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR04MB8003

On Sat, May 18, 2024 at 02:37:43PM GMT, Qu Wenruo wrote:
> When extent_write_locked_range() generated an inline extent, it would
> set and finish the writeback for the whole page.
>=20
> Although currently it's safe since subpage disables inline creation,
> for the sake of consistency, let it go with subpage helpers to set and
> clear the writeback flags.
>=20
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---

LGTM

Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>=

