Return-Path: <linux-btrfs+bounces-1900-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86164840913
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jan 2024 15:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA03B1C24A45
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jan 2024 14:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3008152E17;
	Mon, 29 Jan 2024 14:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="VKIMvQqO";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="GiZ2zEsg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8400E152DFA
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Jan 2024 14:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706540135; cv=fail; b=IZUSxMdF5pT3mrFJfpbX0y5AwO49PeH3hsIJV85UsJiVf3VM4unBdRtFbZbwmxj0PpzYtDaI5ZQAF8yLeXjuc51lfHZ1f1csBLyT6LerTJ1N1v7MT6fWINOe0eW94MPOnKMKAVyvqwO3GAF7h2TOwBgZ2ThcgEy8nHLZsCgoyTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706540135; c=relaxed/simple;
	bh=oW0zCKzHO0m9V4M6KHA4CwaAX6xdo3BBnvgVBXnMgNA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Yq32n8n85YEfN85xiWdygXh07shFnJqpIef/S7uYNH9l96h+EXHux3ujxN39dSKh0A2C3wOYu7nOX95XGPIjlCHT11/3803j101iU1PoZJZ7LIeTGXMZjLI1ZU+aGRzMO0M7mdpmy9i6dNp4n9YG9p6d9PJG1qN2JpBRX+HvO4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=VKIMvQqO; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=GiZ2zEsg; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1706540133; x=1738076133;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=oW0zCKzHO0m9V4M6KHA4CwaAX6xdo3BBnvgVBXnMgNA=;
  b=VKIMvQqOutvhPOtcpAQEN7Y/QrmJGCcBMyQgY7ZSQ2xSkl7LaA8aq4QI
   GGDfuqaz+irPZQw3Nj2BsycjdYJLa57Xs6nfkyoAYbfJcJgMDob8iCswv
   dlD/ODoNq+fJSZ1egmeBwnt7OuGdPxqV3NczIhRsGn/SFk3h9Joy+f6MY
   AgYwT3CxRoumieQ9MdxqBg5Em/FIX4dlG1TZgsRBhNIkXaz3Xc+AFH0m6
   nuQg/zejbD8hFJntnC5Kuvr6vC3b+aADEztDuNy6cCEYSLD3KqMOdEU/J
   eRq37TEEJTnVd1FaiK7FTOYG3V2dixKHfSh7OWIHmMvq4P7wYfSW53Zvs
   Q==;
X-CSE-ConnectionGUID: mQbl6PyMROOS9AUsBj2HhA==
X-CSE-MsgGUID: o1YnstnfROmmfE7aKUz/jg==
X-IronPort-AV: E=Sophos;i="6.05,227,1701100800"; 
   d="scan'208";a="7918747"
Received: from mail-mw2nam12lp2041.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.41])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jan 2024 22:55:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RVX8gKtNu3d6QVchEGOWVUW8qqztInPGvrXQcPUpbtbZZz8v44r+eMBlD61Jm1yRr2yj39P6nf+kQtWgMLeLummUEk6+Y+3AJoaNpWt+PWTlEiJDOHGiumTb2sZOPQfmMnrDjRf5dDEpcrnpX6EIUjOKyd3giA8SK0MAU8VDbk8z/p7LJ2H6j46MbGbl60TrDqjqYWO2RrfZCMEa9cgxlqAeXrY+XF9CNOQ6wA1jdsmES/Dfdv0I9N7yKGG2v9c6j1W3Qt8GLIWE7PlcXLfCYX7WKzVNeMaEg8zE8MRwVrbdHjKpHJQMfxH5GcfkI7TQeATOLS4V+GGvSWUkihrUTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oW0zCKzHO0m9V4M6KHA4CwaAX6xdo3BBnvgVBXnMgNA=;
 b=i/r40UvNiKwxovY9wpNg2w3QzSag2DYuURgutMM0cREd2anpRZ7eKZq/9uN4o4jRP13hdQ6P9+XDb4iRKqNXYhoeby+J0ExFAHFu5+DxRWM2HQBAFD0mR5aQYNRO4PqVEOrL+hLi4I0mMdA8kYdmQEf0FZQBuBkSIaR/45uygs3/OYdh9N8jAvalKzClujgkMbiJy7blBZO45bbhkYQqXxLdQPzXNw/m9leVg2hJwM9faW5n2v6RXrSMeJ6r6uukzRFu/1vPD0Cgz2TbrXaIvUypJ8al/SSRwj+Pa8japTSq396dmMg+NGcQrePKeIuQunMkcc4wt+HBi6QVmJXHoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oW0zCKzHO0m9V4M6KHA4CwaAX6xdo3BBnvgVBXnMgNA=;
 b=GiZ2zEsgXLOUKWkwcIyriHd06ohLAEjgwLdrr/fFCmFmGbbYF10cbrQgOnxNP6LRsTTEnghBmlWb/joZbR86L3SoJa5IsBAzKCoCCmAM/a8r9iGuGSW8xMvKqkgb4n9exBx8VcXYkrjUQgLAZdVIQXt2PE02ityqKSzVkMsZK+g=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by BY5PR04MB6310.namprd04.prod.outlook.com (2603:10b6:a03:1ed::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 14:55:23 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::a8a:ec30:a6cf:8e1f]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::a8a:ec30:a6cf:8e1f%5]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 14:55:23 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>, Qu Wenruo
	<quwenruo.btrfs@gmx.com>
CC: David Sterba <dsterba@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: Convert add_ra_bio_pages() to use a folio
Thread-Topic: [PATCH] btrfs: Convert add_ra_bio_pages() to use a folio
Thread-Index: AQHaUDUQ5zebuI2jw0Of0ZYmvZ5Sb7Dw5fMA
Date: Mon, 29 Jan 2024 14:55:23 +0000
Message-ID: <cead7376-a45b-41af-8dbd-cbe9dfaee8f3@wdc.com>
References: <20240126065631.3055974-1-willy@infradead.org>
In-Reply-To: <20240126065631.3055974-1-willy@infradead.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|BY5PR04MB6310:EE_
x-ms-office365-filtering-correlation-id: 436abb7f-3b4b-45a9-3d97-08dc20da525e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 fqiFkPCiy0wE1T2NPIVxUD6jt1HMWolYeKYl9lXiYUpc9IBpVc+d8grV4SbPMCwt5pnzB8Bn6fJzAV9T9MQVHHBuwz9TA3kfKXWYvzzFAqb8/ZCQ2EtVy8t6oEProc4Pr1P8OwrU2twKdOn6c+KWqfIQDKlVZSFPoTjgTaxgDSxDHevpNUGZEO4f9aV8REcNnBKzi2YfWTb5PM5t75QXCFWxoF498N/7GspVTyJyyenoTut2EacSvjX0+Zk3gL3EKUPt7UFsb/CGt7589Ly5Ie9QwqzNBHTtKteKdyEvB4OLBzekb4kxuxQHrby3JsFSYyh3TGR1Gqphwwrfc8XAPoX+k1zYiS/EddiGK2Hnmif5TlB6YsaJFjUMSNpfOrt2g8zs8hYvK2F4q1l99eeod4QiLtTBaTPtL85Mae/R+cdtiyner5df4E0+ebm3k8RsMtzqD2d0xtyFSLkHUM+HaCgyZ0l53NhfDoJhhUvrWDwiSjHJq233krrizQAYnFsJPn0HzS4cNZH3ZkGi0rly5+CH3BLjEkCHJYLL7Vwp7iOeJfdiRjjbahhSVoW8x2DfmhxrjrebUGBZ1Qh3G08h7fVPUD3u2OmBa5SqVMuyopw1ED8xQl/0pM5sliS7jdPQVdGGmevyLdYt5HHJGBTUgd8ww+LkIiQTFJmGli9mvqYm+fPkIrfOP4Gd3PkjqtxK
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(39860400002)(396003)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(31686004)(26005)(83380400001)(6512007)(6506007)(53546011)(36756003)(31696002)(86362001)(38070700009)(82960400001)(66946007)(5660300002)(8676002)(41300700001)(8936002)(4326008)(38100700002)(122000001)(316002)(478600001)(66446008)(110136005)(66476007)(91956017)(64756008)(76116006)(66556008)(54906003)(6486002)(71200400001)(2616005)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dXZMYTE5NzcrOE95V252aU0vTkc3R0U5OUtqK3hlOEFHM0ExUmJaeTRvU1BM?=
 =?utf-8?B?RWd1d3lPMGROTmRISlNpVzFiQjBEWEh2UlN5MitkbDc0cStmNC90ckRnZUky?=
 =?utf-8?B?SkI2czRXcGxtWlNERGJtQi9VUi9NSDZ1aGRpcThTSCtmU1lqd0xBNTJJMEJI?=
 =?utf-8?B?OHdBekVQU1hMbDQvaUcwVktNTHphbGVtK2JkYVdVOFdIQXk3WEJJRVRoQnVQ?=
 =?utf-8?B?SmtRazdlYTdyZWtBRERBTkVsM2dhSUhuemhLdEFFNkhUdWdaUWg1d2RZNXZ3?=
 =?utf-8?B?UnFvYnh0QUxuTkdYOTlkZjlCWElXa2pSSDZTU3BVQW8xODBPQzkzVjZvMnpP?=
 =?utf-8?B?RG5xUE1kRVVrMDhhNWcvOWQ1RW1aSTFTdEJmMFVLSUVZZGZ5RjVha0dhWnVm?=
 =?utf-8?B?SGRVcmRMMWd5eUc4T1ErTVZ1NE9yNkZjdVhpTDFxY2s2ZjA1dVU3N1ZBdHpE?=
 =?utf-8?B?R0xxV1ZyOGxNVDlBQ1liQmR0MGJmMjhrVGRnRXhyeFFyRldudjZxdjdMbC8y?=
 =?utf-8?B?blpQbklMU0pqN2FaQ2R0bWxabzc2RVR0WXowY1Mwak1tdnNWUkhZQksxTG42?=
 =?utf-8?B?Y1dDOG4rTVZlamdSeDNHdWpxb0V4QkJseFBkUVByWlJMbU9pa2grVWNkYml0?=
 =?utf-8?B?Uk5uSDRYc3RUQnBESHJRVWhxRHhaZnNzSlA3enNIaElNRUN1VThFaDlSUnBS?=
 =?utf-8?B?cUJFSG9IcmNlRnlIL0Z1VldUaW1mQ0Irb0VsNUcyNVhmQXRNd0JncmRjYjF5?=
 =?utf-8?B?eTlxMXBEVHd4Q21iSVlleUVuc2JVWVhsWklsRFVzczRaaE9vd3dZQ2tQYkk5?=
 =?utf-8?B?VjRTTURKeXpmRnJkRlM4OGFyR2ZMN1g0dXN0UlFwYmR2V1lrZjV4Yys1MVhl?=
 =?utf-8?B?VGpObU5rQ2JmQ1ZJWFBnbm5CWDZTV1ZCVmdsaThtOENXdmVqTGlZbXRMZmpO?=
 =?utf-8?B?eXZnZzlMaWs0alFlQWxGTUI2RmRtZlZlemdNNjRGK3hOZEQ2V0VNSm1hbzFR?=
 =?utf-8?B?dUd2R2pOb1d0TU83dGZUSEVtM21abUc5eGNiK3grUnJPTHUxT2lBSGxHL29K?=
 =?utf-8?B?WjBqQzFSWTJPQ3FpYkdDb254N0xreUxwQlBrcHhvY245TW0vMkxXZm9Uc3R3?=
 =?utf-8?B?d1lGbW1Kd0tnVGhtWk5FMmcyTnVpWXZMVUpQMkZ1THNhU0l3RkRVMDhvcXoz?=
 =?utf-8?B?bURsMmJ0RStoNE5SRWh5c2FQSVBhdDl5SkRMdjdOc01BT003ZUY0RVM5WjVl?=
 =?utf-8?B?cjEydFdUbnFsbzd5YXRyTGNnM0pqT1lKeVU0cGQ4L3FwUkh4WnJLUkZoNmFJ?=
 =?utf-8?B?aDB3bzNHYXFTaFR1anZlWHBpRlBvd1RWQnhPY2dOZ1VjemdrcXJvZHJ4Q3JX?=
 =?utf-8?B?OUR5dzYvcEh5MU0raHhFaXJRU01FNkx3eGtyeGp1ZVFXang1VWtxY09DOGY0?=
 =?utf-8?B?aWQ1dzlWSkVRZ2JjVjBCVmhoT0ROeUxIeWV2cFpyOWt6REE3bTJoMVQzc2RX?=
 =?utf-8?B?S3pFYnFDSFRuTlNHNEJHQWxVdnpUSEl2amw3MHhlcExvVzFyTURPTVBaVzM5?=
 =?utf-8?B?SllZOXB1ajNnTFFrT2ovU2N1Nm9XZEZCdmtXZjJrcGhjM0ZYZzF5Ym5jamRY?=
 =?utf-8?B?WDVIb0o2MWNWUXJ3c3M5NVdKUzB0d0xidDBRTUk3eml0ZzhWcDJNQXpOa0F2?=
 =?utf-8?B?bVg2YTUxR2Nod3NRODRxeXVzYXFSalNlbEdaemVuek8wV0gvMjA5MGhnK1dk?=
 =?utf-8?B?bkFHTkFmZllXRmFtYjdoNU9OWGhycTJrMWFteC9CMitzejdTZENFQnNHVnJM?=
 =?utf-8?B?MzZRbndSRUdCSllxWWN1SXoxcS93clBaa09lZ21wSjZHb3pMREFBN2ZtcFpS?=
 =?utf-8?B?MVBGVXVMSkxxakdmcVZ4eUw3VmJCSStWOVhnaU5Ga29IejhlR0hWY1ZocS9n?=
 =?utf-8?B?R1prWjFqaEF0c0IvcTZubDFzZEVaSTJYUlVCb3IyT3ZrN2pxU0RCdVpSelNi?=
 =?utf-8?B?MFIvbVdoU0J6b3FIQkVvOXpuQlluOHNKRVI2cVlyeEdxdWU2aHZGWVV1RmZq?=
 =?utf-8?B?Y2l5WXdmbldPK3BWa2VqK0M4MVhGM0xXbzRPTUdCTUhmYys4Y1NsU0xrU21a?=
 =?utf-8?B?RlpadjBSSld4NU05N00vVHQwRzJMV29jZ1gxUk13U3RHMURHZHZENmRDNG9M?=
 =?utf-8?B?QVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <770CBD835D51194885CAF4695D6FCE44@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EjIWPzLMx0DHYT3PCnRTNWuT6jm1Sj8PzBNyjCQF9HX7IS6qH1xYgQRiFAdoyIE026ZwRgrPS85TqmZ4hpO9HKcvi8dPTv6QZgYXyZ9QLpPQDV79nV9r4lN/YJ2paao9ho4MoSUOGAQezaqlr4sVOROxoSGjbZ4wYL0h5ARRQ9Dh1e/YfFf+gAyql5HnEyrn7ZHBOdahiulfSOcUVrVfPFaU9OKrJ9qpuAZfUyDwDovr+JkshLY8bUKcEM++nXqpzyHFzCUzbdpU0C/EMQzRqsaWhZ0PmrqBgpz3yndyQ+XYoqEumkO2prvhks7yvL1eYcCe0gIZUYgLzZgAvZswyCwV+fiQGR4BZilqp2ERb0+76j1dDhxfR+MfDQh0xRxL1oF9FDMxjeQvNtYmq1crWSGSSDqovpDDTnys7KoynlfcE0GTgpoq2ARpyZrfIu4L22c0fJTosmp0joDT1WbrtpznYbSfU6KwhUuscQLyNpTVA+Z2CRp6G9sU2YYXy8Xoe61TdmI0oyQX4s8+s3oSRX4NepELP3t4gJ3t334i8H74OuqLJppnn1AkEjVLhkc+yTkVFqEYu4fD5y24VJbUTltMhyXvovcIh6f5Ap0v6L2DFtYkWYbLUVeKAKoyoYUd
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 436abb7f-3b4b-45a9-3d97-08dc20da525e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2024 14:55:23.6591
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RhwwusKw7WAgX7wkPhV0lY26KhKgSGYJY8EgxDZtGVjXON53dW1Vop0cSQnUNvHrXDfmEpEfXxbqr4DCDdZxC0Zk/2fj7e6XOhYUzLY65Yc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6310

T24gMjYuMDEuMjQgMDk6NTMsIE1hdHRoZXcgV2lsY294IChPcmFjbGUpIHdyb3RlOg0KPiBBbGxv
Y2F0ZSBvcmRlci0wIGZvbGlvcyBpbnN0ZWFkIG9mIHBhZ2VzLiAgU2F2ZXMgdHdlbHZlIGhpZGRl
biBjYWxscw0KPiB0byBjb21wb3VuZF9oZWFkKCkuDQoNCkhleSBXaWxseSwNCg0KRG8geW91IGhh
dmUgc29tZSBraW5kIG9mICJSZXZpZXdlciBEb2N1bWVudGF0aW9uIiBmb3IgZm9saW8gY29udmVy
c2lvbiANCnBhdGNoZXM/DQoNCkknZCByZWFsbHkgbGlrZSB0byByZXZpZXcgdGhpcyBvbmUgYW5k
IHRoZSBvdGhlcnMgUXUgc2VudCBvdXQsIGJ1dCBJIA0KZmVhciBteSBrbm93bGVkZ2Ugb2YgZm9s
aW9zIGlzIG9ubHkgc2NyYXRjaGluZyB0aGUgc3VyZmFjZS4NCg0KVGhhbmtzIGEgbG90LA0KCUpv
aGFubmVzDQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1hdHRoZXcgV2lsY294IChPcmFjbGUpIDx3
aWxseUBpbmZyYWRlYWQub3JnPg0KPiAtLS0NCj4gICBmcy9idHJmcy9jb21wcmVzc2lvbi5jIHwg
NTggKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICAgMSBmaWxl
IGNoYW5nZWQsIDI4IGluc2VydGlvbnMoKyksIDMwIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL2ZzL2J0cmZzL2NvbXByZXNzaW9uLmMgYi9mcy9idHJmcy9jb21wcmVzc2lvbi5jDQo+
IGluZGV4IDY4MzQ1ZjczZDQyOS4uNTE3ZjliYzU4NzQ5IDEwMDY0NA0KPiAtLS0gYS9mcy9idHJm
cy9jb21wcmVzc2lvbi5jDQo+ICsrKyBiL2ZzL2J0cmZzL2NvbXByZXNzaW9uLmMNCj4gQEAgLTQy
MSw3ICs0MjEsNiBAQCBzdGF0aWMgbm9pbmxpbmUgaW50IGFkZF9yYV9iaW9fcGFnZXMoc3RydWN0
IGlub2RlICppbm9kZSwNCj4gICAJdTY0IGN1ciA9IGNiLT5vcmlnX2JiaW8tPmZpbGVfb2Zmc2V0
ICsgb3JpZ19iaW8tPmJpX2l0ZXIuYmlfc2l6ZTsNCj4gICAJdTY0IGlzaXplID0gaV9zaXplX3Jl
YWQoaW5vZGUpOw0KPiAgIAlpbnQgcmV0Ow0KPiAtCXN0cnVjdCBwYWdlICpwYWdlOw0KPiAgIAlz
dHJ1Y3QgZXh0ZW50X21hcCAqZW07DQo+ICAgCXN0cnVjdCBhZGRyZXNzX3NwYWNlICptYXBwaW5n
ID0gaW5vZGUtPmlfbWFwcGluZzsNCj4gICAJc3RydWN0IGV4dGVudF9tYXBfdHJlZSAqZW1fdHJl
ZTsNCj4gQEAgLTQ0Nyw2ICs0NDYsNyBAQCBzdGF0aWMgbm9pbmxpbmUgaW50IGFkZF9yYV9iaW9f
cGFnZXMoc3RydWN0IGlub2RlICppbm9kZSwNCj4gICAJZW5kX2luZGV4ID0gKGlfc2l6ZV9yZWFk
KGlub2RlKSAtIDEpID4+IFBBR0VfU0hJRlQ7DQo+ICAgDQo+ICAgCXdoaWxlIChjdXIgPCBjb21w
cmVzc2VkX2VuZCkgew0KPiArCQlzdHJ1Y3QgZm9saW8gKmZvbGlvOw0KPiAgIAkJdTY0IHBhZ2Vf
ZW5kOw0KPiAgIAkJdTY0IHBnX2luZGV4ID0gY3VyID4+IFBBR0VfU0hJRlQ7DQo+ICAgCQl1MzIg
YWRkX3NpemU7DQo+IEBAIC00NTQsOCArNDU0LDEyIEBAIHN0YXRpYyBub2lubGluZSBpbnQgYWRk
X3JhX2Jpb19wYWdlcyhzdHJ1Y3QgaW5vZGUgKmlub2RlLA0KPiAgIAkJaWYgKHBnX2luZGV4ID4g
ZW5kX2luZGV4KQ0KPiAgIAkJCWJyZWFrOw0KPiAgIA0KPiAtCQlwYWdlID0geGFfbG9hZCgmbWFw
cGluZy0+aV9wYWdlcywgcGdfaW5kZXgpOw0KPiAtCQlpZiAocGFnZSAmJiAheGFfaXNfdmFsdWUo
cGFnZSkpIHsNCj4gKwkJZm9saW8gPSB4YV9sb2FkKCZtYXBwaW5nLT5pX3BhZ2VzLCBwZ19pbmRl
eCk7DQo+ICsJCWlmIChmb2xpbyAmJiAheGFfaXNfdmFsdWUoZm9saW8pKSB7DQo+ICsJCQkvKg0K
PiArCQkJICogV2UgZG9uJ3QgaGF2ZSBhIHJlZmVyZW5jZSBjb3VudCBvbiB0aGUgZm9saW8sDQo+
ICsJCQkgKiBzbyBpdCBpcyB1bnNhZmUgdG8gcmVmZXIgdG8gZm9saW9fc2l6ZSgpDQo+ICsJCQkg
Ki8NCj4gICAJCQlzZWN0b3JzX21pc3NlZCArPSAoUEFHRV9TSVpFIC0gb2Zmc2V0X2luX3BhZ2Uo
Y3VyKSkgPj4NCj4gICAJCQkJCSAgZnNfaW5mby0+c2VjdG9yc2l6ZV9iaXRzOw0KPiAgIA0KPiBA
QCAtNDcxLDM4ICs0NzUsMzggQEAgc3RhdGljIG5vaW5saW5lIGludCBhZGRfcmFfYmlvX3BhZ2Vz
KHN0cnVjdCBpbm9kZSAqaW5vZGUsDQo+ICAgCQkJY29udGludWU7DQo+ICAgCQl9DQo+ICAgDQo+
IC0JCXBhZ2UgPSBfX3BhZ2VfY2FjaGVfYWxsb2MobWFwcGluZ19nZnBfY29uc3RyYWludChtYXBw
aW5nLA0KPiAtCQkJCQkJCQkgfl9fR0ZQX0ZTKSk7DQo+IC0JCWlmICghcGFnZSkNCj4gKwkJZm9s
aW8gPSBmaWxlbWFwX2FsbG9jX2ZvbGlvKG1hcHBpbmdfZ2ZwX2NvbnN0cmFpbnQobWFwcGluZywN
Cj4gKwkJCQl+X19HRlBfRlMpLCAwKTsNCj4gKwkJaWYgKCFmb2xpbykNCj4gICAJCQlicmVhazsN
Cj4gICANCj4gLQkJaWYgKGFkZF90b19wYWdlX2NhY2hlX2xydShwYWdlLCBtYXBwaW5nLCBwZ19p
bmRleCwgR0ZQX05PRlMpKSB7DQo+IC0JCQlwdXRfcGFnZShwYWdlKTsNCj4gKwkJaWYgKGZpbGVt
YXBfYWRkX2ZvbGlvKG1hcHBpbmcsIGZvbGlvLCBwZ19pbmRleCwgR0ZQX05PRlMpKSB7DQo+ICsJ
CQlmb2xpb19wdXQoZm9saW8pOw0KPiAgIAkJCS8qIFRoZXJlIGlzIGFscmVhZHkgYSBwYWdlLCBz
a2lwIHRvIHBhZ2UgZW5kICovDQo+ICAgCQkJY3VyID0gKHBnX2luZGV4IDw8IFBBR0VfU0hJRlQp
ICsgUEFHRV9TSVpFOw0KPiAgIAkJCWNvbnRpbnVlOw0KPiAgIAkJfQ0KPiAgIA0KPiAtCQlpZiAo
ISptZW1zdGFsbCAmJiBQYWdlV29ya2luZ3NldChwYWdlKSkgew0KPiArCQlpZiAoISptZW1zdGFs
bCAmJiBmb2xpb190ZXN0X3dvcmtpbmdzZXQoZm9saW8pKSB7DQo+ICAgCQkJcHNpX21lbXN0YWxs
X2VudGVyKHBmbGFncyk7DQo+ICAgCQkJKm1lbXN0YWxsID0gMTsNCj4gICAJCX0NCj4gICANCj4g
LQkJcmV0ID0gc2V0X3BhZ2VfZXh0ZW50X21hcHBlZChwYWdlKTsNCj4gKwkJcmV0ID0gc2V0X2Zv
bGlvX2V4dGVudF9tYXBwZWQoZm9saW8pOw0KPiAgIAkJaWYgKHJldCA8IDApIHsNCj4gLQkJCXVu
bG9ja19wYWdlKHBhZ2UpOw0KPiAtCQkJcHV0X3BhZ2UocGFnZSk7DQo+ICsJCQlmb2xpb191bmxv
Y2soZm9saW8pOw0KPiArCQkJZm9saW9fcHV0KGZvbGlvKTsNCj4gICAJCQlicmVhazsNCj4gICAJ
CX0NCj4gICANCj4gLQkJcGFnZV9lbmQgPSAocGdfaW5kZXggPDwgUEFHRV9TSElGVCkgKyBQQUdF
X1NJWkUgLSAxOw0KPiArCQlwYWdlX2VuZCA9IGZvbGlvX3Bvcyhmb2xpbykgKyBmb2xpb19zaXpl
KGZvbGlvKSAtIDE7DQo+ICAgCQlsb2NrX2V4dGVudCh0cmVlLCBjdXIsIHBhZ2VfZW5kLCBOVUxM
KTsNCj4gICAJCXJlYWRfbG9jaygmZW1fdHJlZS0+bG9jayk7DQo+ICAgCQllbSA9IGxvb2t1cF9l
eHRlbnRfbWFwcGluZyhlbV90cmVlLCBjdXIsIHBhZ2VfZW5kICsgMSAtIGN1cik7DQo+ICAgCQly
ZWFkX3VubG9jaygmZW1fdHJlZS0+bG9jayk7DQo+ICAgDQo+ICAgCQkvKg0KPiAtCQkgKiBBdCB0
aGlzIHBvaW50LCB3ZSBoYXZlIGEgbG9ja2VkIHBhZ2UgaW4gdGhlIHBhZ2UgY2FjaGUgZm9yDQo+
ICsJCSAqIEF0IHRoaXMgcG9pbnQsIHdlIGhhdmUgYSBsb2NrZWQgZm9saW8gaW4gdGhlIHBhZ2Ug
Y2FjaGUgZm9yDQo+ICAgCQkgKiB0aGVzZSBieXRlcyBpbiB0aGUgZmlsZS4gIEJ1dCwgd2UgaGF2
ZSB0byBtYWtlIHN1cmUgdGhleSBtYXANCj4gICAJCSAqIHRvIHRoaXMgY29tcHJlc3NlZCBleHRl
bnQgb24gZGlzay4NCj4gICAJCSAqLw0KPiBAQCAtNTExLDI4ICs1MTUsMjIgQEAgc3RhdGljIG5v
aW5saW5lIGludCBhZGRfcmFfYmlvX3BhZ2VzKHN0cnVjdCBpbm9kZSAqaW5vZGUsDQo+ICAgCQkg
ICAgKGVtLT5ibG9ja19zdGFydCA+PiBTRUNUT1JfU0hJRlQpICE9IG9yaWdfYmlvLT5iaV9pdGVy
LmJpX3NlY3Rvcikgew0KPiAgIAkJCWZyZWVfZXh0ZW50X21hcChlbSk7DQo+ICAgCQkJdW5sb2Nr
X2V4dGVudCh0cmVlLCBjdXIsIHBhZ2VfZW5kLCBOVUxMKTsNCj4gLQkJCXVubG9ja19wYWdlKHBh
Z2UpOw0KPiAtCQkJcHV0X3BhZ2UocGFnZSk7DQo+ICsJCQlmb2xpb191bmxvY2soZm9saW8pOw0K
PiArCQkJZm9saW9fcHV0KGZvbGlvKTsNCj4gICAJCQlicmVhazsNCj4gICAJCX0NCj4gICAJCWZy
ZWVfZXh0ZW50X21hcChlbSk7DQo+ICAgDQo+IC0JCWlmIChwYWdlLT5pbmRleCA9PSBlbmRfaW5k
ZXgpIHsNCj4gLQkJCXNpemVfdCB6ZXJvX29mZnNldCA9IG9mZnNldF9pbl9wYWdlKGlzaXplKTsN
Cj4gLQ0KPiAtCQkJaWYgKHplcm9fb2Zmc2V0KSB7DQo+IC0JCQkJaW50IHplcm9zOw0KPiAtCQkJ
CXplcm9zID0gUEFHRV9TSVpFIC0gemVyb19vZmZzZXQ7DQo+IC0JCQkJbWVtemVyb19wYWdlKHBh
Z2UsIHplcm9fb2Zmc2V0LCB6ZXJvcyk7DQo+IC0JCQl9DQo+IC0JCX0NCj4gKwkJaWYgKGZvbGlv
LT5pbmRleCA9PSBlbmRfaW5kZXgpDQo+ICsJCQlmb2xpb196ZXJvX3NlZ21lbnQoZm9saW8sIG9m
ZnNldF9pbl9wYWdlKGlzaXplKSwNCj4gKwkJCQkJZm9saW9fc2l6ZShmb2xpbykpOw0KPiAgIA0K
PiAgIAkJYWRkX3NpemUgPSBtaW4oZW0tPnN0YXJ0ICsgZW0tPmxlbiwgcGFnZV9lbmQgKyAxKSAt
IGN1cjsNCj4gLQkJcmV0ID0gYmlvX2FkZF9wYWdlKG9yaWdfYmlvLCBwYWdlLCBhZGRfc2l6ZSwg
b2Zmc2V0X2luX3BhZ2UoY3VyKSk7DQo+ICsJCXJldCA9IGJpb19hZGRfZm9saW8ob3JpZ19iaW8s
IGZvbGlvLCBhZGRfc2l6ZSwgb2Zmc2V0X2luX3BhZ2UoY3VyKSk7DQo+ICAgCQlpZiAocmV0ICE9
IGFkZF9zaXplKSB7DQo+ICAgCQkJdW5sb2NrX2V4dGVudCh0cmVlLCBjdXIsIHBhZ2VfZW5kLCBO
VUxMKTsNCj4gLQkJCXVubG9ja19wYWdlKHBhZ2UpOw0KPiAtCQkJcHV0X3BhZ2UocGFnZSk7DQo+
ICsJCQlmb2xpb191bmxvY2soZm9saW8pOw0KPiArCQkJZm9saW9fcHV0KGZvbGlvKTsNCj4gICAJ
CQlicmVhazsNCj4gICAJCX0NCj4gICAJCS8qDQo+IEBAIC01NDEsOSArNTM5LDkgQEAgc3RhdGlj
IG5vaW5saW5lIGludCBhZGRfcmFfYmlvX3BhZ2VzKHN0cnVjdCBpbm9kZSAqaW5vZGUsDQo+ICAg
CQkgKiBzdWJwYWdlOjpyZWFkZXJzIGFuZCB0byB1bmxvY2sgdGhlIHBhZ2UuDQo+ICAgCQkgKi8N
Cj4gICAJCWlmIChmc19pbmZvLT5zZWN0b3JzaXplIDwgUEFHRV9TSVpFKQ0KPiAtCQkJYnRyZnNf
c3VicGFnZV9zdGFydF9yZWFkZXIoZnNfaW5mbywgcGFnZV9mb2xpbyhwYWdlKSwNCj4gKwkJCWJ0
cmZzX3N1YnBhZ2Vfc3RhcnRfcmVhZGVyKGZzX2luZm8sIGZvbGlvLA0KPiAgIAkJCQkJCSAgIGN1
ciwgYWRkX3NpemUpOw0KPiAtCQlwdXRfcGFnZShwYWdlKTsNCj4gKwkJZm9saW9fcHV0KGZvbGlv
KTsNCj4gICAJCWN1ciArPSBhZGRfc2l6ZTsNCj4gICAJfQ0KPiAgIAlyZXR1cm4gMDsNCg0K

