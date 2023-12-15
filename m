Return-Path: <linux-btrfs+bounces-975-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1394814A8D
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Dec 2023 15:32:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5A681C2349A
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Dec 2023 14:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370A7538A;
	Fri, 15 Dec 2023 14:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Yh6AWIx6";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="vozIJeS9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9505CEC4
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Dec 2023 14:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1702650719; x=1734186719;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=fpeA1fF75CLUyRjfOXYdh26RXBIvzKuDWovb3QfWfCo=;
  b=Yh6AWIx63aCkUymL/jCt/eDwLEmomFQd7mDaQmTzBtAYONDsiYIgv8hm
   3KHw+1tJJac+0w/0nrZTPHDdtgAjcFB+zNIXaBlM8bFCe7yxSggZWFZm8
   vxGjZQZwJGGY7KDkPl9GeppwcVAyXg0w/+EDEpvbvCUmDXMQXgIQZT8GL
   /e4G7Vil0Jj1wuU53oGqlyCBe4+xixHK8KtL8qeOpptvZ6UtPRR4d7/PT
   7OAYnd+nktUK3ij7kgRJ7hVx/+2QnIW0EP6QPSE+RErh8FMYyjU5XjUc5
   tGRcXerlQAcizTNLgQ3iIB6BI0Ak7X0LFkzWPhvUO+DtoX14thf3DIUNb
   Q==;
X-CSE-ConnectionGUID: YA6FgcYoQ0yiRLJ8/Iuf0A==
X-CSE-MsgGUID: 69PupIn2SAyc8cOd2YnEwg==
X-IronPort-AV: E=Sophos;i="6.04,278,1695657600"; 
   d="scan'208";a="4992451"
Received: from mail-bn7nam10lp2100.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.100])
  by ob1.hgst.iphmx.com with ESMTP; 15 Dec 2023 22:31:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BM9y3EKJM7qfBcx3k78yIHgJWASzDP04OoeMzBHRnDERRUEwcu8zqaVqtG3ChDUba0ceKPdoQ7pj6cNGFSna2mJel8eAJ/HqPXvC6EqExBBegdzsO44oxoclZ+nghvwhINLc5RzvbVfCUIPBvVltOczyx8YYjjbrajU+NjdMmSZWhWmkrqX7/yZ8EJJjvzZ0SPuFwr0xoSl9/GbcI6b0OHaKCVi7l4MEMnmBQIrBAeCkVI51NsSlCI00r1Ol4+Fcb3YVmhQTX5kqLHbgdfSRhwRt+ZQsRr+ws0Lyy1E69javxBxfrlOSDpeSQ3WoJ32Ci3xu1Uoft3uGGI35ESZN6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fpeA1fF75CLUyRjfOXYdh26RXBIvzKuDWovb3QfWfCo=;
 b=hVbrs1DAR9XfyuC2MqGZjWPzK7RI9t2bike4IlO+pzLCxhKPte9RNXff7y4uySqu8d/SpO4GSvRYApQBz+2xWOEpGeHJ0tCEBAjzYRO13bTslkTf6R6XSXE3sTAZmhsLixU1xJpeOraMp3gzvoB0rRWm/jlECvvyI+bqbHtHrsFjwFuVg7R8FaQOkLTuMKkTArlnR+CHOrXLMFkys0e8qEFJcfx7gQYhLd2ro6eCXhW8RCMEAeqap8CkudAdYBIceJAH2iEayVPHjWsgAHIg5RnkQSVyOeZPDI3VWT/VHjnpgD576h0M4dhpAxx1G22Yx1C9NPjA7tSmxYdtZ4RKag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fpeA1fF75CLUyRjfOXYdh26RXBIvzKuDWovb3QfWfCo=;
 b=vozIJeS9y9Ypx/shzGssQJ8f8s+w0G8GkayussG/VB7rjlxdDkPG+hia5Nj/NJqP9o/6qHivyqrETrwW/78otZpTDpcplkO3QhDqbSDBTx/cXoHmjlbnAD+NCU0L8c/RiwuK2cD9RZkzFerb0gccYx6rf34QywC2lrV77HW8AkQ=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN0PR04MB8062.namprd04.prod.outlook.com (2603:10b6:408:15d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31; Fri, 15 Dec
 2023 14:31:48 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ea3:9333:a633:c161]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ea3:9333:a633:c161%7]) with mapi id 15.20.7091.030; Fri, 15 Dec 2023
 14:31:48 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>, Qu Wenruo
	<quwenruo.btrfs@gmx.com>
CC: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba
	<dsterba@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] Convert btrfs defrag to use folios
Thread-Topic: [PATCH v2 0/3] Convert btrfs defrag to use folios
Thread-Index: AQHaLqiPFcB40UOVekiHWhlDrTCEOLCqaY0A
Date: Fri, 15 Dec 2023 14:31:48 +0000
Message-ID: <3d59dc81-18f7-4c81-8f19-af4b52a5ff16@wdc.com>
References: <20231214161331.2022416-1-willy@infradead.org>
In-Reply-To: <20231214161331.2022416-1-willy@infradead.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BN0PR04MB8062:EE_
x-ms-office365-filtering-correlation-id: b828b5d5-288c-4a4d-60c0-08dbfd7a927e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 NvseTTUXCTuD1SZS2EUSqPD4sgYwLTzEeKrnt0Z/oePSvjwuMJ79XdjW4jXoGonZmc4Nl9M1AFo/4oXgTlcwcGVbfvMHel5jIc9IKnlRVamXLTJ96lyBtRMMLBVSt5iNMNddcYL0UNtbkEw1joJou6QSOmCMEwfO3p84PugQa8P50E2AXz/JQkdKBXVN+dBwoA3cX6UxPpIdsRKs6pBWDc1D62mT5cRf6mDpGnOAi7SnftfBHdMFXFJgH83CAd6cZU10genOGOwANJmfkdN1qmFiFgH9tthrShfYUXlxTcuuVzfqyWGRKxt5D8G9b75pDljQz8RLSnXZ51oeu/cB1fCmdx74370aORMH/4g39VsvP3LwXFoLOsbCOQa0F+HIbCzKjvlhHHjrtLY7lVJxQQT+6q9ZBLrB6RFVranIKf8v0NXq6rQWpaE+hlojTiMGB+E4Q+7prQxonRW805AUfxe0jsrwretnGpuNr/pvZtd2g5Kdh7xNw1r7BkQVYxvv1ZHmYndVfUkcyJLJs1p1juHmBhHDnHXelX3+Ho4P55E8qgm2mMWyGTq4arqQlxGIwFkAt2WbQhx6PfP4hJeUyOBaKkUEIqkohtUm09QgWqZdpGU818mGpJdnJy2ukV+B2iRHGFPNpYP+nlOxO/wABfx+0/R7+svaILoMU9wtEpz/i6dzh1/8DJDZ8QUgm7Lg
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(136003)(39860400002)(376002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(31686004)(38070700009)(110136005)(76116006)(91956017)(316002)(82960400001)(36756003)(86362001)(31696002)(122000001)(38100700002)(83380400001)(2616005)(71200400001)(53546011)(478600001)(6486002)(2906002)(4744005)(66556008)(66476007)(66446008)(64756008)(54906003)(66946007)(6512007)(6506007)(5660300002)(8936002)(8676002)(4326008)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VWJ6YU8ydm9TVlZSOHdHMm41bnRoY2NKN2lPVi8xanZsRmtUdjIvanVwRm1z?=
 =?utf-8?B?c0NZWWVmRHJLbVFvZFc4OUQ2dVJkNmRiODdyWCtDY0xsa2xDMjZMWm5MNVZ4?=
 =?utf-8?B?dHU5OThUYzg4KzJWS0JxZUhzZTdyWGE3MGU4ZlFoZE9nSlhWYVpHckNLVGRx?=
 =?utf-8?B?MDhXaXF4VjlWNWkrTGZhOGdxbGVJaUhUMFFiY2ZPanVsaHdqakRPczExZC9F?=
 =?utf-8?B?SHZ5UzE1YURsUWFaN003d0xOd2d5OXB3MmFrVlRFc3Y3ei9CSTZwODlXblJ1?=
 =?utf-8?B?UW9neGpKc3RYbmpIQTF1Y3M5Wnk3bXNOWVVzR1ZYbHhyaTRPNDVQakRiMWZQ?=
 =?utf-8?B?OGFPR1hybnN3Yll4ei9BYS84QzBqZHBGWmZ6UXk1TVA4Sml1eUtrU3BINExw?=
 =?utf-8?B?MjV5RnRpYnppK2dUcW0zWkt6UHBHWGtVTGpTMXp6Qkw5QTRBcWEyQU5NOVVD?=
 =?utf-8?B?WU1KUzJ4cFhvTnRRWEZ2NUkwQ0pXQWgxOVpQaXBxVDJQUUhhVG9ZQTNZL3Ey?=
 =?utf-8?B?MDFNTzQrRGlkcXVYT253RGphTUlaZ2NLenpCZ2RGcm9remNRY21vT042V3BT?=
 =?utf-8?B?Y3hkYk1PdHI5ME9IZk56Q296SDA2U2lmbWxBMmFNNlJ0aUNqN21YdDJuL1lP?=
 =?utf-8?B?UUZmU0ZuTWZuNHQ2V1hYQm13RVhNYU96ZHlybnJzbnowZEg4ZzFTNUt5dWs3?=
 =?utf-8?B?Vk1uVmRCRFcvTzBSNHg4ZGJ0NHdiRjNwUkxZeFg5YU9obi9GSkYrak0rZUNv?=
 =?utf-8?B?TEF1N3FITEozbjRsR1RrSmJPYUJVRW8xd3h6dUUwZERuYU1CYW1tV094WVBu?=
 =?utf-8?B?UHFTc2NSY012S1ZJZzhqVS9CcTVkWDRyYWx0Y2hRdkc0SWRTRVBrRWIxMXpk?=
 =?utf-8?B?dFZTcHdOMUhzRlpadXR1Y3ZSRzQxNWxLcGJuaFNqQmVWaWZMT2tBUkJUZ2p2?=
 =?utf-8?B?SFhWaDBmdE5LazVZNHVwY0FTYzZzaVNJaENqalJEUkxJTnRWSzBGenNHU21q?=
 =?utf-8?B?ZjBsRUNyaXJ0TmU5SW5mVFdMcjRQdkxJREdqRm5tMzNqS3l3VzNwNGpRTllo?=
 =?utf-8?B?V2p5Mzc1TGxRdVlzRjltdFlMVlVNNUZSWnZkeWI4VHhkVGVhNktLa1Mzb3Jn?=
 =?utf-8?B?QzhGdnpHV1YvTWdmblc0SGFPVmRDM3JjZTNNUERuSG50bEZTdGFIdnNOZzQ5?=
 =?utf-8?B?KzBRTGIxWXJocEJGT2JFdjY0SlFRUkpvQllhUDRVZWZSMG5TU3NRRUZwRGNv?=
 =?utf-8?B?d3VBMVl5MXVZalpoWERhd1BRMWtYT2JxdUE1cmR3WWFnSk0wS1dCQUpqdis3?=
 =?utf-8?B?VWlkOC8rNmdhbFRjVUNLZWNTekFmajFlVjZtdkVEaE5YVDBEOElTRHBUOEhS?=
 =?utf-8?B?SFNLZkZUeEJtSnBiK2dUd0hTWlBrSC9zamxOL1lNVzRVQVBCWW1KemNhOWI5?=
 =?utf-8?B?RmRXT2hGV3BaN1hoQm5tcXJhejg2VE01aTkrT2piNzEyQzhJdWFIU3lHVy9w?=
 =?utf-8?B?UGR1aExzVGlXMDAxMjZzMmk1MUNQWVdON0dzYTluL080N013SmxwS0FSRmhT?=
 =?utf-8?B?K0pyRkVNa1h3S0IxOXdnY2J3NGhvTjRmNnBTZzl0cFlqOEVMVHp1QWlnSnZY?=
 =?utf-8?B?TzlVWVdFVEUyWkRrRlliVWloZDlFQlhGRlgxNE9nSDYwOVJ2SnZUdmFBcTkx?=
 =?utf-8?B?N0taUVd0RWY4RW9IOFJKRFY3V2dNL0Z3T3FBaHpuZGdOT0h5UWFlMUt2NWlx?=
 =?utf-8?B?eU8zeFEvQ3BoYzAwbVpZSjRPOTZCQXZIRWc1LzRMYmFuR1U5ckh0NVdIU1pK?=
 =?utf-8?B?b1B0VmVoblIzU0U4REUxVXUxek5mODdWQlpLc3NDN1ZFUDZzdE9GV3ROS1F2?=
 =?utf-8?B?UDQrdklXM0Zlam9YZ1dCYlZYNEVuL3NuNE9vMERRL29FbUJUMUlyeVN1WlZI?=
 =?utf-8?B?ZUd6NTBrdlVJeWF4ZkpnWDBlRGY3eW8zY3RMZGFnTElmS3JpNnlPSUVqMVVG?=
 =?utf-8?B?NkYxdDFPK2IvdWFLZUZEWG5FY0xlWFBrU0JsNGZhWk84aXZTOWtjcGhJaFIy?=
 =?utf-8?B?MzJKZEVkVWpmZmUxT2F1WnE4VFpuRWdhVENoTE9PR1l6ZHJabzl0cWVVSzla?=
 =?utf-8?B?aklIekhxcnNrOUViNlNNT2p6MWx0M0NPTkYzYnNlNzEvcU5na3BNbW0yU1pu?=
 =?utf-8?B?eVA0aHhOQkFNTXdXdVYyY0VZQ3RnaTJqWENOLzNMYld4SDNWVGd3aVltNXc0?=
 =?utf-8?B?OTFrM1J2cDhEUDBuN1dJWXBVMHVBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3EA7AA6408905349BF93CC649DCCC335@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IWwavjmKSGig9vvz8CyknuENDIq2qZiC3rV/DxjbIMLL/cW0dNbEpBAYtfDCBtEZS5AInJk8sE5XbgMlQ+irtIWLmkv7RiwMci1Jf42B69T3/WdGS+pgP4C80isz8ZFfe+YmQUitcTi44O/I6+RpM24HIvcZcDu400v8DOwVdsEoR1sG19RWee8s9zG4SOVYs8cS1I+qOrMyUC2/CTZY8qcoENM15G1CYGhItbKc7a++qYstA5I40NMClWtnuOtaZq+o97dWgIuwvk49RZpL3nuJ4onlJV0bKuzbRRPRi4gEA8N0ZDFf7YdS0tdkhmKF6PkuRHesCt7H1lC9xhBeNU3bq1Gk5N2kQjcQTOA6lJPs3QVJ8pSXvQ57fCEVHMavY9jq6N8CohBxsse41zLqLUWUAEZznYoUTGugpEgh7RRdhW5PlRwSmdYYi0J9nM+GJurQslPTZwqKlDSrXNz+5h2/f9TGCZlwBDtEzCw+w4+4SA5GOMlnUFdUsrysI/rGuIfPsVYyY8jSenYO6rEw3q6RMgyaVsQ2e5KghCMODSoXlKoqXIeYOGThaaRuwcGRmOed4jQXBbt93cKxRB3A7PS9ytLE8/VJXRgzAeDCuQnJrDXaz+5uQz0MSElIpsrp
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b828b5d5-288c-4a4d-60c0-08dbfd7a927e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2023 14:31:48.8030
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BhPsBb//nxd7cxzRp7wkmIxC1FW/EX+VXek0VcvnpEWvJYQKIR2lkmLQcE8WfDDFc3jSYhdXkct0jmMwqCMVf5jcmiavUCzxNu6wP7FYg/E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR04MB8062

T24gMTQuMTIuMjMgMTc6MTQsIE1hdHRoZXcgV2lsY294IChPcmFjbGUpIHdyb3RlOg0KPiBVc2Ug
dGhlIGZvbGlvIEFQSXMgdGhyb3VnaG91dCB0aGUgZGVmcmFnIHByb2Nlc3MuDQo+IA0KPiB2MjoN
Cj4gICAtIEFkZCBzZXRfZm9saW9fZXh0ZW50X21hcHBlZCgpDQo+ICAgLSBSZWJhc2UgdG8gbmV4
dC0yMDIzMTIxNA0KPiANCj4gTWF0dGhldyBXaWxjb3ggKE9yYWNsZSkgKDMpOg0KPiAgICBidHJm
czsgQWRkIHNldF9mb2xpb19leHRlbnRfbWFwcGVkKCkNCj4gICAgYnRyZnM6IENvbnZlcnQgZGVm
cmFnX3ByZXBhcmVfb25lX3BhZ2UoKSB0byB1c2UgYSBmb2xpbw0KPiAgICBidHJmczogVXNlIGEg
Zm9saW8gYXJyYXkgdGhyb3VnaG91dCB0aGUgZGVmcmFnIHByb2Nlc3MNCj4gDQo+ICAgZnMvYnRy
ZnMvZGVmcmFnLmMgICAgfCA5MyArKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLQ0KPiAgIGZzL2J0cmZzL2V4dGVudF9pby5jIHwgMTIgKysrKy0tDQo+ICAgZnMvYnRy
ZnMvZXh0ZW50X2lvLmggfCAgMSArDQo+ICAgMyBmaWxlcyBjaGFuZ2VkLCA1NSBpbnNlcnRpb25z
KCspLCA1MSBkZWxldGlvbnMoLSkNCj4gDQoNCkFwYXJ0IGZyb20gdGhlIG5pdCBpbiAzLzMNClJl
dmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRodW1zaGlybkB3ZGMuY29t
Pg0K

