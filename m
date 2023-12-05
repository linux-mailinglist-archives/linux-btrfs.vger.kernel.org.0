Return-Path: <linux-btrfs+bounces-657-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE27805B20
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Dec 2023 18:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E0F1B21073
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Dec 2023 17:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17CDE67E96;
	Tue,  5 Dec 2023 17:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="RPIKbKKg";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ENibmazx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B0DCA;
	Tue,  5 Dec 2023 09:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1701797389; x=1733333389;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=GQdLeusgjuMnPdD+gz3h9vf29U15GJsDCdcK0wTuhrE=;
  b=RPIKbKKg3Iqec5sxB99JqFdjJLZGGPZi2MSavZLwFPpJpM5RM7HLZz6y
   3i1z+wvd3/EXZTxChfCXgb8dHGJ2PTFlysNLd86NoS3cHeO2hNf3//on+
   SWdeYcxB7dsqUHQLMsJD3xgpc95Sa766nmfCSFJmd+DQWBDeXUqM4/zq1
   8xNYgZ9HikAnLNC7KgVP6Z2p3uAX6wSfdKUEFxVPnDLXrHVgcUfhVff74
   t4eRXKRjZdatIDDUMFuaGWbxJ1CxqE5AswpTAIPZfXWo0fcXiGn2UTuPp
   0JEDPCFHZtECqlODyamd9trc7WeXUSmIxbu2MukiaGwKC0hkjkxW4KiRS
   w==;
X-CSE-ConnectionGUID: //J8/ae2R5GaBpHDdg2tcg==
X-CSE-MsgGUID: 5K29CVl1Tky8UD7jJ4UmDA==
X-IronPort-AV: E=Sophos;i="6.04,252,1695657600"; 
   d="scan'208";a="4108819"
Received: from mail-mw2nam04lp2168.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.168])
  by ob1.hgst.iphmx.com with ESMTP; 06 Dec 2023 01:29:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SZc27JyaeVWw0omKZr4CBOpYQC0BZoMc/jeF8fqs1FQKJP51UbvjMwvGajsAxQ5bU4boUmQnJdi1AKL1QCjWgp7Gpg+7aBUeDP/BJiFqGCtaDExZJ+OXNVB5T2W1/0rthkJKqAltZHpKq1MAFBj1buK/VJgaghkfapfcxKYUbrdAIIe8K2njtok3rwtsUjF8rmoEeodzmYb+H34HYuaX8yj41K2+PXe4ZDIAGOBs98i6O0fMF++YmXbKmzx+S5x7mAwlD1Dnm0/RfHURrirqMiHuzFjcYLxkE0PwiR+KfURe3HfIg/+yCKwi7npkZ50jZug1vRqg7U39+PRRkppGIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GQdLeusgjuMnPdD+gz3h9vf29U15GJsDCdcK0wTuhrE=;
 b=VYGT59rGshTKaEg58wqvnRNnD2zTKU+XK5n2YnF5gSFduOWrbuAHRsOYND7sdueIJRCIxzoml24rOatsy144kxuQ2Q+Xf76jDEO0dLlsijD6fkwrtUhznSHo0QMvPvdTbBE4FtWWkoxqs2uYDnygJw68wBpf2/uOUJQMfCOnboaPtAbjWLJB46ajSRjGxIhthttDMLV2uGHnI/Ae+/4AZYCIV6lhG2hfmF588qqHq7859Iq+VA4ecA7jMC4rgq5AsqMilgKhasUuNE7vXjDuOggPCaeJBC6UsumbBNby57r9QqCh+xi6zmmwMwiXh7gU7eQgWrJb3ytwTn5422M+2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GQdLeusgjuMnPdD+gz3h9vf29U15GJsDCdcK0wTuhrE=;
 b=ENibmazxnMIs+C1DfqIaZqmL5Jj8Krlb55NpYGH9PkzhC5akywt8C2X9IQ9MCl9J2m4npJZTwPtucKNjXS7yCm/rA9yLiSmcbAS7yGC4Qk2xwpxHnkK1NrraW7B74fUxvbqHnAYvp5VKg9SxxrmDu0tuTGDuW+8fp8YL5XI1C20=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MW4PR04MB7300.namprd04.prod.outlook.com (2603:10b6:303:73::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 17:29:47 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ea3:9333:a633:c161]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ea3:9333:a633:c161%6]) with mapi id 15.20.7046.034; Tue, 5 Dec 2023
 17:29:47 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Filipe Manana <fdmanana@kernel.org>
CC: Anand Jain <anand.jain@oracle.com>, Zorro Lang <zlang@redhat.com>, Filipe
 Manana <fdmanana@suse.com>, "fstests@vger.kernel.org"
	<fstests@vger.kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 3/7] btrfs: add fstest for stripe-tree metadata with 4k
 write
Thread-Topic: [PATCH v2 3/7] btrfs: add fstest for stripe-tree metadata with
 4k write
Thread-Index: AQHaJ3jp4tja0Ok3sk24VFnrCwf3i7Ca7VmAgAAB94CAAADngIAAAiCA
Date: Tue, 5 Dec 2023 17:29:47 +0000
Message-ID: <56cf77f2-afc2-4792-9801-e41c195fc451@wdc.com>
References: <20231205-btrfs-raid-v2-0-25f80eea345b@wdc.com>
 <20231205-btrfs-raid-v2-3-25f80eea345b@wdc.com>
 <CAL3q7H62=-Y9KZeLQeVAAy8Q2STDdTsUEJLC9BrEFsVyTJON6A@mail.gmail.com>
 <dc1aeaf6-ec9d-4035-b61d-7b1d38189830@wdc.com>
 <CAL3q7H4TqofDBfe+KUE_FRH55D5A3ra-b-3d4aQm5r2B=aFA4Q@mail.gmail.com>
In-Reply-To:
 <CAL3q7H4TqofDBfe+KUE_FRH55D5A3ra-b-3d4aQm5r2B=aFA4Q@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MW4PR04MB7300:EE_
x-ms-office365-filtering-correlation-id: 54916410-2b2b-4d54-ec7c-08dbf5b7c74e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 lTcz8vlgcq5sU54MgA48io4Ljn8bTI33gKCdDPftha4OsW/I1girvbznr1xJGsKp1f8dOAfxSCdYcD8k6ptNZAkLqXy8pibBlzO3RuH3SncRjgbRoxUCjjh+TY6izdqKLNbODqd8j3/vi5L0uLegLoixhEaIhJK2UlY7urHgkNKvU/t8Pn7B1FPQAXRez3to7ahTVdiVYGEAeHXFeNJURxOL96OSzNRqasRuxC+drEJi7V2pYSQ1D5umJHzWTj91Ov/RV21lHht7WT5n2BmLvavIsQRBEOzznZswpOho/9VnfQA3XVWrOwUefKYqUsZrIsrNndGEBbyOfCGwImw5VtUfmalLTB8oGSrrCEfeNhg6/NsPxf5GSWwxhNZCupH3Jh7rs0qst9bkjq3T563y8YaY+Jf4jdto69gtB+cNg3TF6GXwN30e3Bm0YvJKI9lM0PWIPLg/CRGoi3VXWdgsVRVOiF9Kp7Q0KWH3FX9/ERQZr5L+F3OU4qdgAHlp/vvJ2HL3zV/scCikJcuIUzJ/Cbs4g43YqFPhbL0HW/pQqCD29cbxQ2sCJT95k/cT3zwaAZzWrh/+oaeESAy+osD7luuPKylUwGTFUA70BIzgyh3pffP3+sfN2PIkEBbvE27/yEojwwwcC00qbriOEDUmmr6WVo5WplYYYPnfz4sZ/5bWX9c/d4ps0AxpySvKVZS1
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39860400002)(346002)(366004)(396003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(66476007)(66556008)(6916009)(91956017)(76116006)(54906003)(64756008)(66946007)(66446008)(316002)(478600001)(41300700001)(6486002)(71200400001)(36756003)(5660300002)(4744005)(2906002)(38070700009)(4326008)(8676002)(8936002)(86362001)(2616005)(82960400001)(122000001)(38100700002)(26005)(31696002)(6506007)(31686004)(53546011)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K0N1amRpSlNQVDFucHIzRzB5S3Y2dm51ZzgrYnRlVXZUOFNxTEpLREpTTUVi?=
 =?utf-8?B?V3pxY0JpTFhCWmhCeVQ2aEJGd28vbC9lMnp4ZVc3VnFzcWRTN2tsenpDOEFJ?=
 =?utf-8?B?V2xUdzZKckNIaDhjNFJXZzJnSHRRYmpTbEc3TlhQYUVpa1hyNFZSUlVJSGpw?=
 =?utf-8?B?bms3U0dFWWZXTlE4czFXK3FoM2tHa09kaTk0cm5tUzlxLytUL0xrc01CazA3?=
 =?utf-8?B?VlF5RVNjSFhmNkZWY1VvQ0N2aW9XTzNOL2N5N1UwcDA5czA5dkhGaDNrRXJn?=
 =?utf-8?B?L0h5Yy9OeW5LY3JXYmxqRGE4eWdQUmUwaE92U1lkYVpKQWpzUkk4eWZMUnRv?=
 =?utf-8?B?TVgwbDNPd3I4b2NPSytINnNmT1lFckltOXM4WlJwSEdOS3BpZnR2eHFCYmx2?=
 =?utf-8?B?eGo2eGxiZExNRE43VzUxWjNrYVZTaVRhV3V4d2R5OWJjOGZpaWRYWHFOdDlB?=
 =?utf-8?B?QU1ta3UySnN6NWlQK051VkRhQytuaE5idDRUSzMzK0lvRXJvR3hpSEZIQWp4?=
 =?utf-8?B?elVUVi8yaFFGdzhwNmtFeVRwQU9JUjFVb3RFM2NOenFYRDAreE5ESkcyRkRY?=
 =?utf-8?B?M2J6Mkt6NVdJV2hYSkdTNG5CWGNnSkJQRTUwR2ZyYVhKVHM2czIxUG1laHNH?=
 =?utf-8?B?ZFdYdmpiVXlDM0JtRHZua1VMeHJKOEptWkg1bm91R0tvdmpiNmxEM09sZnFS?=
 =?utf-8?B?L3VQNjB1YVhEZklIT0pPazFtMklLMUJ0YUprZklRVjV2QXQ0akFvTm1jU3l3?=
 =?utf-8?B?d0VsYThaSEFQY0VhckJ3NTBaVjM2dVpGcHZpZ2RSTzNRbGxPbHV1OFJ5QzFJ?=
 =?utf-8?B?ZTR0NGwwbHNHTjVSdzFKTXIxV0krMDMwNDNyQnY3WjF3cFUvK25UYWhRU3ZX?=
 =?utf-8?B?MGZlRFVjSVNVeFRrbkNILzgrUmVvbEhyZDBJcDFpcEhId1Zhc2FsaTRMZ1p1?=
 =?utf-8?B?YktXSjFQVTNmaXFPc2FxTEpqS3JQNVlzWFRlSXByemY2dXRrQ3hXQThYdkZE?=
 =?utf-8?B?dnpWQXhaU01jeWxSY3ZEbXRQRFNWOUlUaFpNUnVTOGtiTEZUd2dvVEZQWlUr?=
 =?utf-8?B?RGJFaTVVbjNKY1V6dURLek4wMnhZYVY3QWNSaVdJVlM4WWNUU29LcDlueVox?=
 =?utf-8?B?NUJxTWc2Y2dncGtRWDB2Y1RIcnJ4azNySktUY2p2d0tsQkNxNVFUM1F1Vkhq?=
 =?utf-8?B?NjZRS2JLa2tWazl0WXJMMGEvN3VwcVlZUHFSbWJ6Z3dPbjA0bjNtNGg0d2c4?=
 =?utf-8?B?cVMvUG1wN0hEQ29pQ3dPbnR5YlQ2WUQzYXF1bEJZbkZzZTRoTENWcjNCemdJ?=
 =?utf-8?B?WHByTkRiOU9IckovZUk4QzU0cFE3bWU0a2NiN3dETWNWM1hNcWQyQVJMRGNI?=
 =?utf-8?B?L2cyMDBqRVBnU0ZhdEFlcld3NExwdjFWVXBhdS9QaWF3NlUyUGJ0UEJKWFU1?=
 =?utf-8?B?ODVOSmFONmIyTFpkbmwxYUV6Y1ZVZldCeTd0WUpDWXhJN1BVZW10b1Z2QUtn?=
 =?utf-8?B?L1hLMk5yTWtFWitSUzlPTmNZRzNySFdTV1l3RDNPYSt4emRUVTAvL0E3R3du?=
 =?utf-8?B?Vk4rVmVZcThXc3dBa21HdEl4QUhPSFZIeStMeUdkMWttMjFHVVE2ck1OM1E4?=
 =?utf-8?B?WHo0N0JydkQ0b3AyREVZZkZmaWdhenFCdE9OdE5KT2dEZzN0dEJsU01nNXov?=
 =?utf-8?B?aEVycXFTZGdmbFV1a2ZTZVN4MmJ4OGY4L0IzcVluUFhuLzJ3QW9yQjFPRDdE?=
 =?utf-8?B?MlFucmZWVnYzQ0hTcU81bUE0MXloMFhyaldDOFBqQUVvemlXaHJkWmIzYVRm?=
 =?utf-8?B?VUVQZXByT21ISnBKTXlzaUhpTkx5aUw3Tkl2NWo5Y0VaVXRDSVcwanUzQ1Q2?=
 =?utf-8?B?NkxGV1laMEdzVDN1T2VNM2hLcG5Jd2NzQUdzaDRVVVl0S1hEQjFUMCtDZlQ3?=
 =?utf-8?B?WHBEd0pHN0E4T205NjJuaHoxekJjU0gwV2VpVWlWd2g4YnZXWmFMcUpmWE1U?=
 =?utf-8?B?a21JRTZINXRYc2Zoc1NDMVBwMlhXaGxPQjFTMlFoSXRBaW1la0hRZ0NsSld5?=
 =?utf-8?B?TGVVeTlNMGV4YjdCeFpQMUNvemFMZmxkZGJJQ1YzdWd6U3NRd09QMzNxNWla?=
 =?utf-8?B?NGk5SDdwZ2sxcStOaXYraXRNeXJkQlU3SzNYQmRjOHJKSmo0bjN2NXByUjR5?=
 =?utf-8?B?SEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <063EB644B953004E838A511FB5354D98@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0V/s4jvRUe4HtBnYB3kzdPwwXzbU2XMuS0Ii57McQ+EBRce9rMVAxWgXd+J1VsLctSNBjvbjH1K2VRGrTj2XLBfs3sU9MG++p7n2udUKzyMqr+0pJ4EfMal2Lg1D2AA0mX10djOUWrm1q/L6EdCJuDWSZLFPKk/MdGdUtEKF7eDIR+K9IIGVtEsj2VcMFcf0fHJFOjXgDKJZJ4kcKAjI2myyw3iNMspeSkyJ/RwZNtQC3FtqkigVuRFFKBUmkmWFYsZ7YEXQAXF0gNmghDkaCGzyhtl/u7Y0qV43iRskY4RkB4gt49kzhUWUtxMOsYb7Gxqpn0OfxJdVA2+KDrZX9rQN6Ax846jrDYV/LaHtEH7YkDmTXQlZXyX6AtJdDSe/hVIeqEMn1YgO9LI7cYtclCu4+hoDMiXGCGoQTTygsvQfFpJUidyK0gkgbZLfGRr4q/GmR0mdd1JSnMRPw48R72tKeu3EfKqRS4LjM/FMzVtvsJ444sfiQEyp6ngBAwzOEK1/Ws0J+o0zOn6ftzLTK1r5cMgPWWcioWcPiTL+CIhEebVvaxSKJ+5ujNdE/62Gx0Jxm/ypns9ZKqyq2kn7a6oqKJwR5oNjNzfhDAZb9RNgCv77Wk7VV6eE3gBKh35sEZL5CA1kMtvaa46qc6SbzMrVrdqA5IlcgBJKhSe29amW27Do6MBIlLQdIaw9IXMrEGHyiUszPh0PJMuLP8JL89UDWpwFrYF6GgVWeX/8cRtbZx7fkey/EmdHTJgwMAo/1hTC5AE03SswEclhnS+ZqaboQOe/zyM1kiktyaRHMkojna/3jPSPkhYPgCGjAAPy7iJypZ0CXGJmZuNta6dMN5HkeBKHm4/HAd/PsH3WU5eS67cd9X6ptjEKN1DkLHHYrahSUuG/1Bae9yuaMDVBSg==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54916410-2b2b-4d54-ec7c-08dbf5b7c74e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2023 17:29:47.4409
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B6jT9ED/QhXUqA+iI4GMzlMEvs9BMQbcj5zb4+gSqJ2moQ2MtA6l6+075szs/Q7uqBYm2AA9xuBigkjuhccsWo3KNDdHs3TJKEO1Iq5w12Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7300

T24gMDUuMTIuMjMgMTg6MjIsIEZpbGlwZSBNYW5hbmEgd3JvdGU6DQo+IE9uIFR1ZSwgRGVjIDUs
IDIwMjMgYXQgNToxOeKAr1BNIEpvaGFubmVzIFRodW1zaGlybg0KPiA8Sm9oYW5uZXMuVGh1bXNo
aXJuQHdkYy5jb20+IHdyb3RlOg0KPj4NCj4+IE9uIDA1LjEyLjIzIDE4OjEyLCBGaWxpcGUgTWFu
YW5hIHdyb3RlOg0KPj4+IE9uIFR1ZSwgRGVjIDUsIDIwMjMgYXQgMTI6NDXigK9QTSBKb2hhbm5l
cyBUaHVtc2hpcm4NCj4+PiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5jb20+IHdyb3RlOg0KPj4+
Pg0KPj4+PiBUZXN0IGEgc2ltcGxlIDRrIHdyaXRlIG9uIGFsbCBSQUlEIHByb2ZpbGVzIGN1cnJl
bnRseSBzdXBwb3J0ZWQgd2l0aCB0aGUNCj4+Pj4gcmFpZC1zdHJpcGUtdHJlZS4NCj4+Pj4NCj4+
Pj4gU2lnbmVkLW9mZi1ieTogSm9oYW5uZXMgVGh1bXNoaXJuIDxqb2hhbm5lcy50aHVtc2hpcm5A
d2RjLmNvbT4NCj4+DQo+Pg0KPj4gWy4uLl0NCj4+DQo+Pj4NCj4+Pg0KPj4+IEFueSBpZGVpYXM/
DQo+Pj4NCj4+DQo+PiBPaCBmb3Igbm9uLXpvbmVkIGRyaXZlcywgeW91IGRvIGFjdHVhbGx5IG5l
ZWQgIi1PIHJhaWQtc3RyaXBlLXRyZWUiDQo+PiBhZGRlZCB0byBta2ZzLiBXaWxsIGZpeCB0aGlz
IEFTQVAsIHNvIGl0IGNhbiBiZSBydW4gb24gbm9uLXpvbmVkIGFzIHdlbGwuDQo+IA0KPiBPaywg
dGhhdCdzIGl0LCBydW5uaW5nIGFzOiAgIE1LRlNfT1BUSU9OUz0iLU8gcmFpZC1zdHJpcGUtdHJl
ZSINCj4gLi9jaGVjayBidHJmcy8zMDQNCj4gVGhlIHRlc3QgcGFzc2VzLg0KDQpQZXJmZWN0Lg0K
DQo=

