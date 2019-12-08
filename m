Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70CA51163FA
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Dec 2019 23:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbfLHW0M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 8 Dec 2019 17:26:12 -0500
Received: from mail-oln040092068054.outbound.protection.outlook.com ([40.92.68.54]:36446
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726667AbfLHW0M (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 8 Dec 2019 17:26:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OcnrKCeWFEkFrpxzJK3cmfpjKz8HABRtxXSRk9qFo8mGRSyGBGZHtTwfKzPGbjinHWeGX3h92ImiUlpysMgVFdgZ3h6XK74NtKDA24wVwitA9APzA8Hw1QPii9mymaklojWN/8guYPLierkSlETiGMifc6koLrhfJVqHAPpdcWb7X2jN0SIkIWr1mLL2lHgBHqxbIvNlg3q1tXoUGrDD6dERKqT6Yu64WC6cZkfvfwIScJ7LKc0YOz9DWOltLN/j7495B4Cz3PTl06POe5J/dQJvjqn9oqWQy3PYcdgHyk0hoA0a0al3geTraY3U0ouX0dDj+C3/27ChUbZATqXMvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jgA/IMB4TAp20asjTz4892tnQettqwdAdV+cqxy8+tw=;
 b=VZNNcUWyWYnvERamUZH7HB+kkQGlFuvgOYzIyYWi9bTsn5fT9cAUbjbCsoOiize/CueHHAimTdt0Uel29SJWugHs+Fqzml4XR8+06DE81XYGN/QuAWkdGDzTfN0huHOzlINL58ZdfeR0BOJ2XfXovJwnLHekySA/3+XeHKVBh/BfDQuUDCDzSAgjjQLoy8lrQAGF4ter0Xt57+OsTVXLGRn4wADDxUTLx2g+ZLqoebtBRhrO+Jw8MmFWXCacZILTBdmlSUtkMyXe2uf8ZUk/sZTwy6br6Cdzf39jdc3+d+iSO1etvl04rOF7Fx9rlSuh2x7YgN/wBGa4DNxU8P+tsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from AM5EUR02FT019.eop-EUR02.prod.protection.outlook.com
 (10.152.8.55) by AM5EUR02HT090.eop-EUR02.prod.protection.outlook.com
 (10.152.9.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.18; Sun, 8 Dec
 2019 22:26:08 +0000
Received: from DB3PR0102MB3658.eurprd01.prod.exchangelabs.com (10.152.8.54) by
 AM5EUR02FT019.mail.protection.outlook.com (10.152.8.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18 via Frontend Transport; Sun, 8 Dec 2019 22:26:08 +0000
Received: from DB3PR0102MB3658.eurprd01.prod.exchangelabs.com
 ([fe80::74d4:b474:d1e9:6fa2]) by
 DB3PR0102MB3658.eurprd01.prod.exchangelabs.com
 ([fe80::74d4:b474:d1e9:6fa2%6]) with mapi id 15.20.2516.018; Sun, 8 Dec 2019
 22:26:08 +0000
From:   Alberto Bursi <alberto.bursi@outlook.it>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: 
Thread-Index: AQHVrhZ8ZOu0+N2Ns0apskXYjN7srg==
Date:   Sun, 8 Dec 2019 22:26:08 +0000
Message-ID: <DB3PR0102MB36581AC49AD2E68EEA5F1F7792590@DB3PR0102MB3658.eurprd01.prod.exchangelabs.com>
References: <CAJ0EP41toGSPQwB4Ys4aNzGGJNDBS-NHgPOcGanBk6d6Nn_LWw@mail.gmail.com>
In-Reply-To: <CAJ0EP41toGSPQwB4Ys4aNzGGJNDBS-NHgPOcGanBk6d6Nn_LWw@mail.gmail.com>
Accept-Language: en-US, it-IT
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR01CA0113.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::18) To DB3PR0102MB3658.eurprd01.prod.exchangelabs.com
 (2603:10a6:8:7::20)
x-incomingtopheadermarker: OriginalChecksum:9267AD8CE8EB7A89D7F775EC9BC0C49DC2DDA82C7BD84CE3BB766BFD7FFB655A;UpperCasedChecksum:7B6047445AACF4BBA744D2660E340BB793E99F5AC6E36AF51042DABAF14D076B;SizeAsReceived:7222;Count:47
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [y4r1l3bpWFFOgx9bAN/hor6xJyA64fYcrbWTfSugA1o=]
x-microsoft-original-message-id: <757f08f2-7dac-6c67-de30-d6847a5f7d8f@outlook.it>
x-ms-publictraffictype: Email
x-incomingheadercount: 47
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 2034a6b5-43f1-46f1-17f6-08d77c2d9f17
x-ms-traffictypediagnostic: AM5EUR02HT090:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ivTkBUIjjEmFyHlKAGgEFo9NVulAIgcqPGoZd7wL+QeIHqYsCx9Ua0SmxQRfYIoSSs7Ror/6CE8W5XNijC/4kJQJldU6gMLQjP/ayLuYRB5uBo3EnqK1/+DAOCC4tMElde9eR2HUtJa/MTrsRwlowYngsdRBiu2VJ+hAkGSoWeT9rTTPVjjBALDzxvNPqIL5
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <C0CA0ABAEBF1FC4796C9EAFDE5CD43D5@eurprd01.prod.exchangelabs.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 2034a6b5-43f1-46f1-17f6-08d77c2d9f17
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2019 22:26:08.4735
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5EUR02HT090
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

dW5zdWJzY3JpYmUgbGludXgtYnRyZnMNCg==
