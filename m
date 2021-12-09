Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3560246E756
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Dec 2021 12:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236458AbhLILRD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Dec 2021 06:17:03 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:8853 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236454AbhLILRD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Dec 2021 06:17:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1639048407; x=1670584407;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=YHOlzflxlh5v+W3k6kl+JViVv6rEyB+a/ngGu+goArk=;
  b=hu65kwi0JVfDsUvO6QAEZ0P7iQddNKKqN0kXGB4AGuS4DGLUusdfo6Wg
   QmMZdMwxgtoGpk/ohJXR9qW54Ze78Hx7pQQWNnNehUyRvjfDjPoRXzymi
   y1r3snsJb+O3iblBBA53T+BIQJ7Xns140ifecSz6JkIJfsTe+tuU5Hn65
   triBfK1p0CvdfLhFWAPkLgb2dapdK3TIeNMS4ehQUV8u8auGRwVhhLNK3
   ysGjgR2OVqudMGqitjWB1BNDJ0YvwE7jbq1jpoFm6V6LCUY/BM9yF8fd9
   0pN8qhyC20yMszsxqEF8C1t7H7gFd3ciUzuhHjDNg1FI84fQR0kGqDBOj
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,192,1635177600"; 
   d="scan'208";a="187835195"
Received: from mail-bn8nam11lp2173.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.173])
  by ob1.hgst.iphmx.com with ESMTP; 09 Dec 2021 19:13:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L6KJ3VyJVUy0AmzMbGUu/JZk+tFb1wqg2789WTj4p+8kzmQUjcNYoLjY/5bToym3xwQDwHvwfX1sElnNajz68hjxgqAs7qJ0SCWZBFGQtSElIEPk/Vm3VOAKxcAeb+VughVrHs7JG3g/i8gEvEdXlXba694y85RmXcpjKSQkTewIQ5FS8ZTLLvBp8d+Ud5J4lKHGrQWigTMVl9ArWL6dp1ad+8wgv8J1WD/lVp/QVPljQQU9/bJolPP0rjCyA80FaM1IbtnPC23BYneXr5ieZsti/oiW9tSCcmWeFEYkCUaTW4QjQx3ZlQfXE/508qlZa7/6Oai3I87xI9H8Ne2SVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+yMmZLajJWCQnMzPh4gi1PhVzl0wtoj6juIraJ4wMBU=;
 b=PtPZXFhZDRUqDnQ+FX5wHd0FKksZl9ReW37i+vI4b0ZeRkg5O6nqF5SzPXBTVFAgFXpcpHV7cgtfFgBK932MYgRxDmUHx8Qxo5Ps0knt57YJ4XHvl+pqVPRX5PxZtDIYmk1DYSnUs77T8E//V6Yov6WQ38MDkbNUgzcoI1TsObQex76X7KA/FRhMQdcA3/ohx6wp8dtiWCjSJV8f58lhdMJ93oEMfa9O/2rWBa+zUiB0n0J1pO6xqE3O+gaAqqCLbjFHgY+jSrDd8jczNskpGjrQq3ouj8WNEsNaQNNcT+7B4UBtEREYCloBil5kxtTLDjO2qnCR9bOlQjISWrF9og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+yMmZLajJWCQnMzPh4gi1PhVzl0wtoj6juIraJ4wMBU=;
 b=tnTBRJ9LQ3HFsiam4AYP/1rpzV9i6z2x5Ypf7kh6z71tZs3VY7AMIVFvW6yWe164vwYi0apvB4aIoPEI357LIAwrQ81hzPsbY3KKJSbAyftrOhB0Sk7cahq6vWdhMjGyh3ka2jFCD3M12cJ82pDXBPJ3FTWh33QZaOnn4/6asl0=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7573.namprd04.prod.outlook.com (2603:10b6:510:51::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Thu, 9 Dec
 2021 11:13:28 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3418:fa40:16a4:6e0c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3418:fa40:16a4:6e0c%3]) with mapi id 15.20.4778.012; Thu, 9 Dec 2021
 11:13:28 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 00/17] btrfs: split bio at btrfs_map_bio() time
Thread-Topic: [PATCH v2 00/17] btrfs: split bio at btrfs_map_bio() time
Thread-Index: AQHX6kkvn7e4gQGU+UGEWJCojwlgqw==
Date:   Thu, 9 Dec 2021 11:13:28 +0000
Message-ID: <PH0PR04MB741670CEF6419687BC70A06A9B709@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20211206022937.26465-1-wqu@suse.com>
 <PH0PR04MB74160D826D891E5E543603769B709@PH0PR04MB7416.namprd04.prod.outlook.com>
 <PH0PR04MB7416374BC39FEF504430C1D59B709@PH0PR04MB7416.namprd04.prod.outlook.com>
 <253c767a-4599-94dd-1c65-34d34aaaebaa@gmx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 17f3f1b8-7b76-437d-3fcd-08d9bb04ed2d
x-ms-traffictypediagnostic: PH0PR04MB7573:EE_
x-microsoft-antispam-prvs: <PH0PR04MB7573FBAA571B8EB4E2D311EA9B709@PH0PR04MB7573.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3vt03o3OJWFQwjGTyydiAxKGNCsHDk1o7q6r9T0yvGHvqqZ6XHAtW50+HFyRbKYX9Hqg9gGu1eVenZRWkDR4obzmo9I032kKKZUClFXeRvZZK97b9APnxkp/y2eGIUpnZO35ygH40RvPF0K8CKyxOMoIZbt51eEK10CKpz5lEKhg6eJjNQMYrBXC3U+F21TZER0YzPk+G4zx733WsDj8IACWPuRFkVWqbM8nKN+twGkoQrym/DqWa9yHp3VmQTFLIWAwLQ9ejVIqSE9XP6v1TYB1Fk/HmbkP0tf5yA9H2OrEJ+2yzug8oBpRxv2TOa3/EDhnKz8dKghe/UwxXVE9v4eHbFyMVFJ0fMcC90bXEK5EA6Jd/zypR/8N2jwERTjwMrrOhgLWY/hGxRrnrbE9ytRM8lji4KeF97HhfRDhMqP39zD3G6sqAafpwDJZL0n6JJtlFu/ngJdeGqW5UZBto2ZzkPIZ7Selxdjb7ZaUes0Pk67yWkeOrsxjoiljCJW61tr4R8QaD/J6jKTYZsUTgInqi0YfLnsIRTzu8zblVmJQvIAbjNtfkFDzM3E8tgN36diH0KQGbk03VfmS/fAKjMJK6vZjf5NbAUASUjmgCO27CVsetfnNOCDx7uLAblJYPO0vQ42Y+Qot8GLe97zx5W9PdflEK0NS7VduenMSyRguPlQKNh+Etaq42vffw9fP6sakJuux/E2PWRY7LPa7jA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(316002)(86362001)(110136005)(82960400001)(64756008)(8936002)(122000001)(38070700005)(55016003)(38100700002)(8676002)(66946007)(66556008)(508600001)(66446008)(5660300002)(71200400001)(7696005)(83380400001)(53546011)(66476007)(91956017)(76116006)(6506007)(9686003)(52536014)(186003)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jzpPszZDJ6Rua+6SMB2/7dqlBN18Ks/IKndbpKQXh38g19dInGUx8rr6qm05?=
 =?us-ascii?Q?n+8NQP490vCxg4gduvoUjE2a8+x5QemApPchJcasRCNYI9bgxbyQKD6+i9o9?=
 =?us-ascii?Q?v4K63eb5rNtwFrRNMwukryMWrGDjs2k9/OYDA8mdhQaKf82NZMjH1/no0571?=
 =?us-ascii?Q?YtpTjvZMF7RFi8+kraH6ey9I19ZNjRh3wIaKHtnfV1HByfZEtBR36dmWLfkz?=
 =?us-ascii?Q?yKWR27q6cy7N3o7jrW5TQH1WNcqAK+UH3InuwW/gckTN5TLaBzafIEVf6oIF?=
 =?us-ascii?Q?uZXBdXdqBtpahdVnhWbMj+wKykYor+aRfUbXzl0vX3FQMkWEqmuIWGqtN9Ms?=
 =?us-ascii?Q?Xg92kvjGPJpD00eq9uPTVqK3YtNsORL6o3CQyTwNB+AcjO/bHuL+E7t2dPrI?=
 =?us-ascii?Q?PmUn+9vDjyQ3+k4KRZiGAZ/OvqDA/d73E5nKZMNl657LKxUAGxDhyFG2DH0R?=
 =?us-ascii?Q?XRqAo/7Q6c4eW9h2vi61xKQp7OlKJtdEj6jyalyVF3OqaKCMIPV4cq7nQIwK?=
 =?us-ascii?Q?g1jWXlkZ9JfmmO0n7EmsG4bkzmztldW63bsG3l8eQjjAFI59LjdBy29jL1iM?=
 =?us-ascii?Q?mmJhAjZpUB4HhkZ+Z6Sbd40yEn0Q0g7j48lRyZv/0Ag7qIn3jmHJ6FPZzHqq?=
 =?us-ascii?Q?u6HFELzkq4s2ftoE86uVoXULVtMSmWkO3L5r8/8PSX8osNwgFibP3xZ64xwy?=
 =?us-ascii?Q?T6o5gnDsG8Z2BA7x7KWd/iPaDfPugziPld78ICc/TwoXSz8eENLrAyJs4Xj7?=
 =?us-ascii?Q?5y39Ym3JLtlfMJkm0UOTnIXAC8uPsPdasVsybbMXSme3qiaPoSXXDs+0+Mou?=
 =?us-ascii?Q?fxtuj/pG4MKQzHw+mEnzxEZwHkTV38dV0d3ElAlUbHpDJPD+EK+ZzrBqAFgI?=
 =?us-ascii?Q?BNO8KUfU6axwVzI7buso7jDkR66Bie3Dk3sttOwvX9BmEGr44oF7Jd6u6lia?=
 =?us-ascii?Q?run4/WTTLsN+ROVL/66a0bcPe15F9B6MZAWa/O8jd6y2WB26+I1HlegJcD6e?=
 =?us-ascii?Q?Z2fbflL2AIMzx8ElOfSxYRXDwNqr9+jByYNjEUkRIGEI5RF7EmN0lVjH4dbG?=
 =?us-ascii?Q?Tt4ipdn29+W1d4MDh14ukSTppOJoKTQcqhAP78N0VeTM+gzqMHdKILhlbf4u?=
 =?us-ascii?Q?CL/uDnAozKoGkMh/4YnKSqx2QgcHVbUoBe8HzqZnT5eIQ60GQX+0m9CYrvnL?=
 =?us-ascii?Q?KqVa3y7jjsVs1N+1wq3p58T3UiBFobfqHeQBDmZkym2NppPRk2+hnf1VU9i7?=
 =?us-ascii?Q?s3nlOJenIfGSqk5HQdTnZJvEcPmDBnJlFLMOr0/DOOlN4JXDhZqvf84qtJqJ?=
 =?us-ascii?Q?uPoG+jvAYzWJyshbyu4/2h0KazdORHp0nOuVBy2OxDe80wl8qPODg8LtI82P?=
 =?us-ascii?Q?9loRT3Apl9puOwdCsvV3Z8oB5D7EBLwoHPhtEZcifJD+S8uB0CFF6I2T1qrQ?=
 =?us-ascii?Q?vCBkanYDoV9y6nXmGW6h5FnJJ5cnvUSIAxLcVNns8ViYGIVF86sQznmmbAtK?=
 =?us-ascii?Q?xQZ57BJjG+pgHcCpC01c02N2tLHxGVudD+p6EF4T40C/bttP2ztEXK5Aatk4?=
 =?us-ascii?Q?y5m3r1NU6IHHWDwl7Ra4uY/tlLegNquAFQ9t30FRAP30TpufVWohHf7X8w3M?=
 =?us-ascii?Q?SvL6kJF76PUtkoaOhBsg1FBSNy7SAx2EcALWVWE0syeG5M6+ifRzl/LHLBJZ?=
 =?us-ascii?Q?xzAS0pG5GKq+8L67Pr+dl8GsnoN60fDFqq7NazxBmiC96dg1UGsanmJ9ozo4?=
 =?us-ascii?Q?UiHqn+m8x7D0EzQdWtUvtV18gleupQk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17f3f1b8-7b76-437d-3fcd-08d9bb04ed2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2021 11:13:28.1999
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3Qjy8AcWtvpkG7EH0YReniLlidZPbYvs5GvOyQTg/yvCT4EweFsIfo/Mqx51CJxhmtTovdJeBPl7Zv0xDZc+6AeR+sKH/fAfBVcstEAAMuI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7573
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 09/12/2021 12:08, Qu Wenruo wrote:=0A=
> =0A=
> =0A=
> On 2021/12/9 18:52, Johannes Thumshirn wrote:=0A=
>> On 09/12/2021 11:07, Johannes Thumshirn wrote:=0A=
>>>=0A=
>>>=0A=
>>> FYI the patchset doesn't apply cleanly to misc-next anymore. I've=0A=
>>> pulled your branch form github and queued it for testing on zoned=0A=
>>> devices.=0A=
>>>=0A=
>>> I'll report any findings.=0A=
>>>=0A=
>>=0A=
>> Unfortunately I do have something to report:=0A=
>>=0A=
>> generic/068     [ 2020.934379] BTRFS critical (device nullb1): corrupt l=
eaf: root=3D5 block=3D4339220480 slot=3D64 ino=3D2431 file_offset=3D962560,=
 invalid disk_bytenr for file extent, have 5100404224, should be aligned to=
 4096=0A=
> =0A=
> No more error message after this line?=0A=
> =0A=
> I thought it should be either write time or read time tree-checker=0A=
> error, but I can't see the message indicating the timing.=0A=
> =0A=
> And yes, that disk_bytenr is indeed not aligned.=0A=
> =0A=
>> [ 2020.938165] BTRFS: error (device nullb1) in btrfs_commit_transaction:=
2310: errno=3D-5 IO failure (Error while writing out transaction)=0A=
>> [ 2020.938688] BTRFS: error (device nullb1) in btrfs_finish_ordered_io:3=
110: errno=3D-5 IO failure=0A=
>> [ 2020.939982] BTRFS: error (device nullb1) in cleanup_transaction:1913:=
 errno=3D-5 IO failure=0A=
>> [ 2020.941938] kernel BUG at fs/btrfs/ctree.h:3516!=0A=
> =0A=
> And this is the most weird part, it's from assertfail(), but no line=0A=
> showing the line number.=0A=
> =0A=
> Mind to provide the full dmesg?=0A=
> I guess some important lines are not included.=0A=
> =0A=
=0A=
Let me see if I can reproduce it with a higher logging level=0A=
