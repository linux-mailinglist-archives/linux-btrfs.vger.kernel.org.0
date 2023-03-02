Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 979D76A841D
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Mar 2023 15:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjCBOZt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Mar 2023 09:25:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjCBOZs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Mar 2023 09:25:48 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D4C36FFB
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Mar 2023 06:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677767147; x=1709303147;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=TN96UgQpLSSznoT15nl/+Sn8AIgIBy4v7+F7F+Mv14zg1xiVQnsgGfsz
   MR4Q7ureS16GBZ1I7Vkyvrd/UihQRiGLh2zF9PqLvXnCCxAQXAmQDH2IA
   0b4ybLCQArKGtumZYP9oQ3WWG4HpF8wiyFe+gWz0+/MjLMimacrLwxXfh
   bDPswPZDQsX2m+bdwSvO+OPKMuN/Vbg43Oe3wy9zln6ed8J6HvY8+oeGK
   btTeh/2APfpouXi1Lf5h4kqStNNvMmCwmTVeP3JSkp40qjCtckEJS1xIi
   6Lxd4K1UUPap5rZ0Nk58pgAi56TcqR4A+LlsDIxXwC/Ti8apLAoz9w/1H
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,227,1673884800"; 
   d="scan'208";a="336612857"
Received: from mail-mw2nam12lp2044.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.44])
  by ob1.hgst.iphmx.com with ESMTP; 02 Mar 2023 22:25:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gza/gg/oDJexJ/JWDhR1EbF1ux5nU3QBZZTXCySizBMir02H7BiYj0RHEWeq52q442J2lvvBC3el0/BgNv0bf+l1XbH9s6oKQm153ljTkx++eSl+DrLZnu0xRLhWV3b//TcZ63IwotqbxV8xLZ9edXko4dyNkQDlp3QmMgukwVZMn1GXPjuvPYp0KqiLhT2YO96/TxJq+sswt9zzsaoY8+ZElVRhr//GT3RHkNnF6rH9dJ6+0GeTgiRgqOppqOPviv5u9OtTjl8pu1x67tM1GDc9a4ThFI+DjWBAJg6g+rbxaI5aPdTNxbtBYArxV8EINNzBFB78hQZZ/AaMEJOcmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=A6sNm3yD9gKJFVbi+2iNA2z/L5dPJf2TItPJ9R91Tc/cIf9fY2XqF2lRYjjrMaIemwEb6Hr1xhdIAe/BNh0ix2VIFqBHYmk8R+lzNJ/4g+Zf2zIBc3fXbLM82RiDxYsi/e5kGrkMwMFmJ7Xrv9ig2uzdTAv3rEl4ctOAsTbfJNQoV0M0BifiSbXuwAY0ATFImNHt/tyODlu/qyRDUfA+0ycIOpJj72Es9sWzNfKGH923WS0yOtfXm8vHQcu0Gb+xZjMJ+WmvjbxcU1yk3iLZMvuiT/xtLUJkzSrQzV212GlBqAyMum5mHWmMt7c/AWND+pE3pEr2Kc1MX0YTXgKAfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=q7ESNx+lZCFzann/cTAquw199icIcC7tEj5I5GXhlbnKRreWd93LmYvcaE4/IJKUonzm+AMeZo59ILItyWeZFvvDfAUxc7gVJ60FxAPWIZ2dCBHEPwk+ye/imUmdXCC8mnnGnd+k/bHXZgYtoqP5qWTlSM6OwdfNFF3YxXdNuNQ=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CO6PR04MB7812.namprd04.prod.outlook.com (2603:10b6:303:138::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19; Thu, 2 Mar
 2023 14:25:45 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%7]) with mapi id 15.20.6134.025; Thu, 2 Mar 2023
 14:25:45 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 10/10] btrfs: make btrfs_split_bio work on struct
 btrfs_bio
Thread-Topic: [PATCH 10/10] btrfs: make btrfs_split_bio work on struct
 btrfs_bio
Thread-Index: AQHZTEO/QUfBjg8EZ0WyQ1u6wpCXSa7njTcA
Date:   Thu, 2 Mar 2023 14:25:45 +0000
Message-ID: <29a6ab47-beed-e889-2483-9aa8aef14bcb@wdc.com>
References: <20230301134244.1378533-1-hch@lst.de>
 <20230301134244.1378533-11-hch@lst.de>
In-Reply-To: <20230301134244.1378533-11-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CO6PR04MB7812:EE_
x-ms-office365-filtering-correlation-id: 005c325e-f18f-416d-0f9b-08db1b2a02b3
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ojl4W0BQMY4PONvgbEZkRyutdOyQ0Vm383QA3IEGpfT4xI08wmjeSF5ajCCk2ePIRRWSR9H+2GdvH1/5WwsSmTunRAA7D+4a66ttpzJ5CWh6CNyV4hYUrrl+z5/m8zgJpwCzQpBY6jz6QLZcDT+2gPKUabqOy39mS7Rbq0Mr+iDJqIei98I6Z9TpqwW2mSLjHlFjYepXlMCrniQ5YFBBBu5wwOAiMglCQmTqmtYjqs1qqCvtw5SvpV1NfF+YXiSWiv8Yh76qsrTgJtBluRKQ9Lb7B472uU8gxa0pcrRMDh4BRtkGZNhWiO4T/LSMu9HHDeqkpq7d4izsDyLcqo2dTFh4+0FyREjzE7NYMiicI1AjEgMSvTKGeajnWnh3ns4X8aG9lBB4Dx3xq7S7XmVdYFrF+6fwch1lQ34mpLh+m9BrsheHiP8taQnaBOh+auivAt2Sznki1LvfvVm3Zgpls64BN9tFGl9BV2jL6z4xges2fuasVkHTlnLf9x7AsEEbMVa2fUwVDGCNgC73RJxz6glGaZZawhbCEUFQi8y5Wptm8pCixs82QGbupc4HQnsF9/9oUc5+20uJWnS7nbBc4dj3y4eJQsfuaOkQkULd8cKTPtUfN4spzY/rYMl21MDSGlMpnZEnD1+/1HuyB+qFJuvqXGOsOEHU8LH9B6QYFLHm+1DBpRj3A3JN/gu6GOtm6et5Dzcg3M3BwnWOELA/4+08JsdHsMSWLUVLB8kjfFuL46ILf8lyZ+aqIlKvoesk0zwwds4V6z+rKggT9uUGig==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(39860400002)(136003)(366004)(376002)(451199018)(36756003)(6512007)(6486002)(19618925003)(2616005)(186003)(4270600006)(110136005)(316002)(91956017)(4326008)(41300700001)(66446008)(66476007)(66556008)(76116006)(64756008)(66946007)(6506007)(8676002)(2906002)(5660300002)(478600001)(82960400001)(8936002)(38100700002)(122000001)(86362001)(31696002)(558084003)(71200400001)(38070700005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QXVnRGZRZXVRdlBJVHhPRTlVbjYxYm9IN2NEUjJORG1GYUFSS3U2Ry9ZUUM3?=
 =?utf-8?B?UFNKYnppSzJlRVFsRjZJZDBscC9UQTRXZG1XUlpzaDFhL2ZKL3ozallIZTdY?=
 =?utf-8?B?dFZsMllRTzNMUUN3dDhyMC8vanQvcWJ1RlNUUklkRDdQbWlHdmppbnJ3MVM1?=
 =?utf-8?B?eURMS2s4K0wyZ25sVWRyaVpDdkdNYVh2QXp5bXNlM1VVSm5tdGNxM0loeTJK?=
 =?utf-8?B?WWxQRXErdkN2RVF6UDFUTGZiNW5EeE5NREFhSG0xL2E2d01JeHlqTFEveHVZ?=
 =?utf-8?B?YWFaSGhxVmc0WVBDWE1jVy9YWlpPcXRLSlNBb1puWTI1SGh3cWQwSkJFQVlP?=
 =?utf-8?B?WTRITEF5Y0p3SldtaSsrN0JLRnFURmoxbThqRGpVdk13dGt3dkVBNlN4NVdQ?=
 =?utf-8?B?L1haQ3R0anRkS3p0a1FZeEtzcWdXaVVFSlJRMm9mTUZZU1JZVklPMnRCREo3?=
 =?utf-8?B?VXdPemdheTMzZWE5V25yYmlVTVVDbHFhQTdGVmU3a3dHbkptaHExUE5qYW9J?=
 =?utf-8?B?eUtXWW03amdTYXZpdzZIdDFHUENnNjhSdHZ6RHk4a0EvUHVrTGxydWFZUi9i?=
 =?utf-8?B?YThqV2Y3RkRpbEFEVUtEK0t6NnVjOG9sMCtpSmh3UFgwNFVQRlhTNzZHM09M?=
 =?utf-8?B?KzNKN3NscGxVQmZlZ1hyMmxoUlJpU0ZYMHBMdFRtdUNsbldlbDJ2L2tobzcy?=
 =?utf-8?B?WlplZ2t3MWJkYnBRR1o2aHYxSHJLTzI4NjlwWmk1THVlbWk5V2tWY0ZaT2pl?=
 =?utf-8?B?YVUyYnBwZ09WMmlpdlZ3QkMvZ0RwdGU3ZkhYdmFkRHR0b2hmc2tXOU9ZMk13?=
 =?utf-8?B?VnNpcnprQVhjYjNoU2c2VFRXRkllTkNzaXBUZHppc1kweDdrWWRENitmSGdM?=
 =?utf-8?B?R0FHeldoQjFITjV4czJGRHhXZDJKeUJraEhzSVBzUG1GcVcwYnlscUpubFNY?=
 =?utf-8?B?ZndWTERSU2Zpd093c2o3RTVtVzVKSUNmdFhpdC9EZk9RUGs1MjJIaWtqalNj?=
 =?utf-8?B?TkNpODVBZmgwWGlLYndJYUJBc1NjZ0trQ1dBdFR5M0ZaaC9laTVJMEpIQlBB?=
 =?utf-8?B?Y2d1aGZDMXYrQ0lReEp3RG9YdDZOTlc3dTZMV0JraHhTekZGR012NkQvYXVs?=
 =?utf-8?B?Mk9CVEpSQ1dzb1Z1dDNwb2ZWOGV3K1VnYXlHWVpWWllVOWw0aFVNYmhLRTIr?=
 =?utf-8?B?UW95ZlhLUTVJd3lIQ0Y4dCtwU01WWisxVTdCb3dHVGF6ZnlFWnpBTERCL1Zs?=
 =?utf-8?B?a1NxR0dRVm1RRlhhN1k0T0lhMm1GMk40aVQ5d3UwMlFORnd0cURWNzF3R1dt?=
 =?utf-8?B?VUdUb042OU1Jd1NaNk1sM2tUekNKc1FSTVNMMU1DSS9hc3pLS29aMXJENnVa?=
 =?utf-8?B?NVdXVVVkeXI4TndJVExlZ3JXUTd2MUpzN1hmN2wvUWhDQjZZT3pBL2RMRGR4?=
 =?utf-8?B?SlBnbG1ielpHVE8wR2lzMGNJZG1nWTdUcXpMb1ZFR1E4ZnltRUdvSEZlQU5W?=
 =?utf-8?B?elpCalF4eXovQW1hSDZGVGg3WWc4NmdjeEc3YkZHOHdiSGdpcXd1MW5yRVp5?=
 =?utf-8?B?MnA5QUI5dysxV3pwempSYUc3RjZCa2xNd1l6Yks1cTFhVEIxSEpaTU5nRVFu?=
 =?utf-8?B?bVN6MVEvWCtBcld1UHZ4S3pweW53MGV6ckcyeG9waXBGUFBoU2JtQVpnM2l5?=
 =?utf-8?B?cGxVUVVnaStabmVGUHpFeURoU3MwbXJFNjFkRDRUcjZXRHNUc2hxMDdRdlZC?=
 =?utf-8?B?K1BQTzB6QXhHa2tpMmx4NjlyVk42aGlIbVA0L0ExMWRMbDEvb0ZyR1A0NG1n?=
 =?utf-8?B?bVJCU3E0enJ5Y0R3ZlI1dEMrTU1hNXV6UmNGQ2pQVEFJcWpFWGdmaEo0V21J?=
 =?utf-8?B?bFZDSEFyNHlzNytDdFk1bkF1NzdURUNNYkFvbGVxSTV2NjB6N1MrZ0hkM3Rx?=
 =?utf-8?B?bkh0RDltWk5qVmZBSXE1OHlRV09ZcFM1Q3Zwcnkrd2xMc1o2NXEzWFBTN0Vh?=
 =?utf-8?B?VWxnN2crK09WWkdrWkoxaXRwU1F2MERlQkpDUkVpYUhGRy9MTDhEQndHMFhN?=
 =?utf-8?B?S0xJNmpYK2JTZmI3U1M2NTlvRFphb1VCbm55UFY3T0VFUlhmd3lXS0VzQkNs?=
 =?utf-8?B?NGdPK3VkSURHc3RIVmRSUlc3Y3BxMXdreTNyNG9MRzlOQlFEdXRxampLZE1t?=
 =?utf-8?B?YTNhVU1vSldvTjM1UWVjRlVMcnY2RnpqMnpPSWxnd1BKRnlEVmx3KzBUb3A3?=
 =?utf-8?B?NVdIR3MvZVJEdmhEdkx4OHprb1FBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6BBC15C49670B3438F9BE42A248DE86F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: QN96w2LGvoWMIlPL6z3ei1xb2pV8En+FDZOV2rlldJm3JhkVqUL90/wf+4xW1elZEpytI22xKPHqoHjKY0PcNpFhRjsE64DwrAhK8PUjdTL08xmDVOE0M6g5SVVO4puDCEu3GjXI9FO52jD/LMjissY4HeERoCO7pbiV0MHdr/tJHRTFiIS7thTWgT8KcQUL7hvz1GT31bxtJ+FW5uI3o1u2dRf3qSq9iYIO61H3tMXinLFKJ8NZ8sHIaEpF9RVPnpZxfZfUEQoaedUfTQVJBLOa5QGM8o8ZUy+cvnzAsfNJkQmxi7L8FKeKmeTnmKZjyTO+9ewHh5NI5pc7M7n1ukc+yZGwsKOpSlDz89DAlGthsx6fhIitkwQEQjExsajzuZ2UMvi22Ji5SkJsYAY40nfKhFSCvwSVS97BsIwZg3ClPVNg7qOoHKIo1+6ytbNTpZbQrM12pxepv9l0Bo3nrQZFVOwCg3zBMz3Wm2FDh8pwRBFq88xjWU+DOsMqRjYQVTNsXlZft6KyTjGgwq02bOzkXYguemU8gZBfl7Jtj/3RYewcG0l+a3jCXYQQ6I7QPZWK/FHw8duldfWHa8csannr0u5d0Ud349mTq/7q2e3+5FoExfchB3Qy3Qkfu8WgoHRIHE/hm1gfhZg4A/ywApw9qHuVbZgdAfJXdWAfehmfEs/zpZnTV+sJTd4Uuj/2Vfk5GIQg5qu6xYcXu31F2wjRal2NexnJ0HE/lchxorJq+dH/lbc1mYTvA2fx7vR91IT1z3IQb85bEtnKtTULNSUFq7Z1pElk6HiwU+7StLCzoinCo0VGuVpiKl6AalcCW0hblANzVmTFP9Rr5Y/HiHXyWo5/gg5t58UiXrJr7vgxl8l18L1bxrdD7WaC0SWR
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 005c325e-f18f-416d-0f9b-08db1b2a02b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2023 14:25:45.0610
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mbz590XbhdNLA7zGAFlmpj1Vu5C7UnV72sp+e3QfSlDs4qRhHR8XpJJPi2h096I6syFTsc7PjqmOcWxr8FztF3KQSmGOK3XU22YuM7xyh8Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7812
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
