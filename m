Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD4EE7AB221
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Sep 2023 14:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbjIVM3H (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Sep 2023 08:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbjIVM3G (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Sep 2023 08:29:06 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F2DF1B2
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 05:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1695385739; x=1726921739;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=gEzclG51Jut8NSVmorg9CYlurlx8OHHKVwa0Np6K+Of60MFfC/ePfDQq
   HTB6VzzXcTSSv41FOu6SSYrOgPMJ0G9jZsuGF1MX3CEa0/ZPurcjjRzgr
   SGMJaXUw+dcJB8cfo85Vo4TV+5+ob7ClM5oz65wt/oyBx/ugQRKhQNqoF
   ZEy0TueoColLjiObwE/Fh3W8/3aJT6LedPjnl0Sd6EHtfypOewBPH1E+p
   K17fQllLZyLoobisIS7XCAYp3XmN9T8cFeaKwUCzgXicYKm1sIogVWC0/
   boaWzL8XF0v1+7tTc8fKeZBdl7urty4O7euEfAbwxse7h8RUB0CTomv79
   g==;
X-CSE-ConnectionGUID: yWhONCnvT4OOq4hyb3JHbg==
X-CSE-MsgGUID: Fh6R37kYQ/mgKA0W4rfXjw==
X-IronPort-AV: E=Sophos;i="6.03,167,1694707200"; 
   d="scan'208";a="249134959"
Received: from mail-co1nam11lp2169.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.169])
  by ob1.hgst.iphmx.com with ESMTP; 22 Sep 2023 20:28:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jKcJZFbTW1c6OH6Hmaifwz/WCcOdYZWHieWggifAZIsiYDyFdNDI9XV2YnSMY/Mr+ik6E4trLqhNuVvT0SpwKVXuuLVcVUchsHDplvG3g3r7BW0qDjmf/HrXsxMWfEZCYMc8SNnAK/A16DWdMfsPgLEtdJcPiWXGmUx02u8kGAvIJWyts6iZCFO03uK1fONl0rBAlDCJYJTrpk+jI5OxWSih3Sj8KwZz6DHaFbJoVKtg+L6jCT6RSWzFwVC3ycQk8yrrAllwUbShgOYB7z1AiyfroIJ3JTro/jVPgx7VFkm0n3mb0/1AkljF0i1DuCNo6CZ4dM5zNqpQzQtzLSc1Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=cIosmbZrapLHeyHJkN4uCf46F/ZL7ietdMWCWS0p2PKV8qp2IdOeghNQRLFxhMD8S6ifJ7KSD+z5IEh/mkiHU7ZjclJrgzfODi/7DRVvemXmWHBNnxRePg7X7hI72/OBYER8j6WjsGiS0x9iJcuj5LrMQb86VHR7tbVei0hVB0oFXjAv3YtWEX6KPnyKiZ3w7jhIArgCH1Uh/TeNre5uZOiSsieVsewdDRXmM+WmAN74yQiso/hKDC7ceel9ervxtcXCd57wavOvuqVZlzVPP5YbB6CAm3v1xnRKvIFI7LZ1omh/0M5wxFp/1+cg1Uemz+Y3WqHE82ZnBQ3EjaV9YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=cKJPeZ+Lijb2KCfxfo70YrDSzOeHCv06fp08EoUpEotcteVP7ZllOtVpVDS97BueUtBevcoxKtN5XkPU+Iea9UFdinrpES6u/ElMRnR0CLgqv5ZRbKnth8TsxyayHefbOlsjDTKI0p7KVriqQ0HfCvTjPWs6xdhFMN1w9I0HFPU=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SA1PR04MB8495.namprd04.prod.outlook.com (2603:10b6:806:33b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.16; Fri, 22 Sep
 2023 12:28:56 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6%4]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 12:28:56 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 1/8] btrfs: relocation: use more natural types for
 tree_block bitfields
Thread-Topic: [PATCH 1/8] btrfs: relocation: use more natural types for
 tree_block bitfields
Thread-Index: AQHZ7UXzOauDp11o8EiX8SJpBd5AhrAmxiiA
Date:   Fri, 22 Sep 2023 12:28:56 +0000
Message-ID: <183e98fc-ebd7-4102-92d7-2e36da91fb79@wdc.com>
References: <cover.1695380646.git.dsterba@suse.com>
 <e62321f3079658ce3c5a278e48c84e5d66c306b3.1695380646.git.dsterba@suse.com>
In-Reply-To: <e62321f3079658ce3c5a278e48c84e5d66c306b3.1695380646.git.dsterba@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SA1PR04MB8495:EE_
x-ms-office365-filtering-correlation-id: f0191a52-0a52-4f11-73d4-08dbbb677d50
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N5zWgwXIKng4kaflehk40ClZVWfMkfvU9Ir4+bZLGXph53075dNmcWSdQENuKonztifvgAUQWJweV2YScdBEPZ7RWyZUM9+q1ctIrRb2iQqkB9lImbDBtrTiecYfJGtsakQubPd7+S+sRbDtiP4ctlWZNyWEwCh/9Qk6kXJj0RYKCftA1KCQCz02zIJVXUMU5D5EJegSS6FWB4UI+RZ/5eAIMVfZmY/zB/iXofJhplHxekGUynBoOEWxc0bYZxPuoO4G+qg+KOwoYEFv24l3RiKsuUsTy5EnMoo7m+1YhU+FfWAwMJ3MpuFM1Lr+HZoaxdaU4Cilg/aoC+Y4/S+LqiOfpl8yCjmob+bN+kKe6SNGK5rGV8R6/+5qrPJ/7f7duCvVcQOPLOLGtKuwr8dLtJ/eTQaA0dnAi2Nfm8jfpqVFlGDa1LL6tvZG66t4j7fQkOK01bNRhWhH8w4bkUtCHwjaU8Hu90aEgnNT4x7LBnAB6yxcrGMOJ9kyoFs6sQpMQymkzO6qIV2cObCDmt8/tC5X2eJG/EpA+TUbo4DNFkTHK+8LmQ8yu06ZNSdIeZdPCQ3lnXHl2SyJzYjPs3K0fLKH1lDdjNVPPKMby8l8LScOs5AizK2EA5TOz0lREs5rm/IHOSPO8DbFpWQ/5Odkbi44aLKJnmezDytQgvNsF4i2SH8bOsfjKSQMd9XjBNie
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(366004)(136003)(396003)(451199024)(186009)(1800799009)(6486002)(31686004)(4270600006)(6506007)(86362001)(38100700002)(6512007)(66446008)(66556008)(76116006)(66946007)(41300700001)(38070700005)(66476007)(64756008)(91956017)(71200400001)(110136005)(478600001)(316002)(5660300002)(82960400001)(2616005)(8676002)(19618925003)(8936002)(26005)(558084003)(2906002)(31696002)(36756003)(122000001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SzBHVlZZR1VWOWdrWGh0R3czb3RkNmFtTkZTdWE5MDd0NzJKVVNwYkhSN1lJ?=
 =?utf-8?B?SXdjZU1kYTEwdVpzdlo4NTVLSkwrMExobVFDMDFZaExQNVFJY09pQ2dUdDJa?=
 =?utf-8?B?YjAvWnZhV1c2MjlXNjVncXoxczkyR1BzM0NMN0s4Mm5OdFRoMm1LTURDZncx?=
 =?utf-8?B?cXN2N3Q4aEhkMC9qc2ZQWDBVaUdJMjZWZXFRQ1NRVVd5ZFlEK2dFeEJzNVo3?=
 =?utf-8?B?SnJOLzFuZTdUKytXdXdWbG1DVDJmZ2liM1dvb3Fjc2c1Z2tDaXZiMmoxb3Mz?=
 =?utf-8?B?Wis0R1V6NDFKZGJXeTloSEM3UE1xSXFRNGJYTHZwYU5JOHh3QUR6bEFiMUF5?=
 =?utf-8?B?dUhOU0FPcnc4U1pTbDN1WkFQWVU4c3RCbjAyeU9mY2czMzZ6ekpmRXhIMktw?=
 =?utf-8?B?b05YdUdHQk1nNkJuOGprNk5vTlA1ODVEZzg5NUVqYWhtOW5xVjVoQWRnREdZ?=
 =?utf-8?B?V0ZMSFpmMEo3SW14Wm5HK1lYbmovNjg4cjZNOTliZEdBaVQzTU10YmFsdk9I?=
 =?utf-8?B?N2pOYW1naFM0MmY0RE1QZU1JWVc1SG5MQXZOdW9oU1VDVVFycWNWaEpVbGFV?=
 =?utf-8?B?Z25TQWd5YVMwYmhoVzVJOWVlYkR4dDBVSDVieDFid1JOU3NBOHVWd3BpRnZS?=
 =?utf-8?B?TU1ZYW14RGt6Q055bEQ0RnlVVEQxRUNwQ3BTd3pqSkhtQi82RnhLMnUrbjFW?=
 =?utf-8?B?VHNvSWJNcE0zcExJbjRadkhtOVoxa2NZTkRYd3RaZXJ5T2xXMjRoZ0NuRi94?=
 =?utf-8?B?cDVwK29hNUFjRXdXa2RVYTZ0b2lkQVRkd0oxRGtwemRkWFJxL1NwRVhLajhs?=
 =?utf-8?B?WGpxZUpnQjRramg5N0NxK1gvR2RwMXFXN05JeFZRSXBWZlFabXlhL1B4QXhw?=
 =?utf-8?B?OHhyR0VWZmNMVWc0NE95dnA2bmRoUzVnMS9wcUtoc0NzdENabWgwYk9GUVNW?=
 =?utf-8?B?YVh3L3phcGxPK05PZkp6N0VBbEI3T0lGKzAyeGxyY3h3SHNTSmE2M3A5UVlr?=
 =?utf-8?B?R21QS1lTcU5ueklXbnV0OVVuUjVBbW4ya2M3eFM5M1ArOGduUGxGNm1hWitP?=
 =?utf-8?B?dUZnSXB6ekpIWm9SUXRiTG5Bby8xRVJGbnZWbTBnS29lWEE3Nm5UMXlkSXFM?=
 =?utf-8?B?bmNKdHhhVjJocW9LNUx6NGtMRVVDTUV1VGJaeEFPL1ZrYkFLYkREZEZ6eW54?=
 =?utf-8?B?ZkZIck50ZWZSQk85dCtyUEFIbXhZaWhYU0w4Mk1YcEVpY3Q1cHZ0N1c4UDZ3?=
 =?utf-8?B?d3lrMWZXSnlzTXNjWmpyaDBjdXpyb05oY0tEWTVTOUFHSDRidEZ1OUx4UVJM?=
 =?utf-8?B?bFVUYlFVMXVNOGxBdzkwcWVQSldEZ21QS1BJYVQ5bVB4SHJsM3VGQ21jYUJL?=
 =?utf-8?B?c1Nvc2dqTnNLbVdLeExvR0lPQ1Y1Tmd3MjkxYUoyeE92bUF4K3Z6L1luWWts?=
 =?utf-8?B?OWdqQks1M0lnWWc0TnRqODhDZEc4NWQ5Q2JocVNWYXE5WVFQTHhYNUltQzE4?=
 =?utf-8?B?bWszZzNRd1ZqWkFtbmI1b1M1VTRWanJSSFJXN001R0g5eUFzSjk5cmFLRXor?=
 =?utf-8?B?by9HUzNBcWpBSXhJcWtxZ0JBVnRKdFlLNnVKZnNqMGhkWEJJcTdVYVlQT285?=
 =?utf-8?B?MEFLWjczV0xWb05yWTd1QXJvbU1TbEFEWVVlRGpuZDlpUFRmL1laUHNXSXJo?=
 =?utf-8?B?bVBGMk5kd1AzRWxsRm8xN0ZnckpadjE0U3FSZzdtL2hndjkyQmtxbVZSakQ0?=
 =?utf-8?B?a3JXT1hQemp5eVhBVlE5Ynp3d2VjU3JBejFBYS9STjduUkF1S2p1V1lsTmVi?=
 =?utf-8?B?bWE1Z3JmQlN1UE0vMW85aTQwZ1Z1Q01qT1o2Tjh5ejBsUWZxRTdCRFZTN3JS?=
 =?utf-8?B?c1JyWndJSEd2RDhOcldhSXJ3L3lhd1J3Zit3U0E5UDVMb3JESjFKYjNFdHFL?=
 =?utf-8?B?QUhZdmJuODJJS2ZVTExkd0NMUjhYYkZJQklJV3N1aUFJZ3FaSmVoT0w5eU53?=
 =?utf-8?B?bzVsY1kxQWF5RDlLMlNTRVpEalRlU1FlMkc2eHdseVFGeCtqa3lhbmQ1NWt6?=
 =?utf-8?B?L0xuaWUrR2x6aElTaTNuSWZhd1RXakxncGdmUmdtNjdTSVQ5OUdKb1BKQXNI?=
 =?utf-8?B?MEg0aDZISnlia1JiRktqSDlsTjgvSUxDNVBwSjBOOURKVFdmRE1zcTk4TDQ1?=
 =?utf-8?B?UEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <44A0CDEA0778A54588A463C3C8080524@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5oN7+m1QHQg3UdFovOOVz4Arogkmnce9H/ov0Q+HajvMSqpjI20U3ISkHybMdYXzna4/baKiWgmKnU8CQUzJz4GAC0/Kg3fXOigGUxIKDeJ628iII4Fm/vxDen2MoVJX9fLpG4rk94voN+r52MgleroF6USUsLUuGUENm9IgGzbyqh2Tmy4UgYG1ofCyfTVXqGP54+Y7Kr2jUbn4Af6fCiVSnlilGiAbvBc0d31MHLEoUw26ZDDlvhJnWM+PqpxfSMYzm/MCTZo3/MBHQ5FLwCRhe0S2jh8gWY2dg4ITYAmWSI+WaZGDSaXSpS+lifaa+qfAOxsflOTfj3378aDjgBRX013I8fsQX6ZKmHQlQsN8WCPU9FY0/dxBFB9OjttmpxtUHNQIFanZlPF09d3NUIgnOr6gjAEXCSezdj/WIepyonMYSsyYDc+pDEPlMOQsibu2RWA6HLH0ZfJWdwMP6UoX0hPSkayxAzzJXGACGsJMz1M53NFY25jbZzc39Vwf2E/sGd0vbNu5wtnQMfWRuo3o3FEu8gJJS4raxwQky+eoUh77u0HjCm7ncdaEulNJVOf6kv2alGEIPiSw1xUcLwer+zlbl12ikcfPYZeKF2n2sYxEGas2ptae1x46bpKgWeWwaO4t4eMqKRQwU592ucqdytIF/R6tMeSd377iM+Fpb4pm8IcqCISJ3ZuBEXaVc0TXEZLN7gzwLSRtH171h6SpkARHnhq2sv5I7yDySDZARzUbFbR7XDyFTsyCa6tuvfIbe0/DA3GZSD8AGjDZddjSGi+hKr80CZ14CUhwR57IY/beRe6047T8FjcZTDSM
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0191a52-0a52-4f11-73d4-08dbbb677d50
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2023 12:28:56.1493
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qDEPPF5f7zBH6scIuJguBLaXCSgrYtgwL0KnrFpkfGuJkSlaOEpzWi+TGknX4GFLLFtdYX6a5EpHCR0J7WA6lD8K2/0ax4DnEK2RVPy6D4Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR04MB8495
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
