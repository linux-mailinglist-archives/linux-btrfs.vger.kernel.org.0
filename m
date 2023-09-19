Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 731B87A6246
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Sep 2023 14:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbjISMNs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Sep 2023 08:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbjISMNp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Sep 2023 08:13:45 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3A9132;
        Tue, 19 Sep 2023 05:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1695125617; x=1726661617;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=UnDYsx/foXL1794mZU+LNc8RMvhKEfWaKC3E6+0NbGY=;
  b=Xdjd1am08IJdWD8DrGp+0kNeCphQ9L4SuR1b2hTOORA1aAozEjz+cAZx
   BTAvFf4+3OzRsbK8RAHgEkl//Iabs7D6/Z/u57Md7wTICWQw8t2bOPgbr
   FxKYmXkf9HRBNdYsIEyymiPpSgVQg2NJP3kW5Jl0qpS+0wIqLnR9lOipn
   DlujyHGELN/r0LKIguMSbxptQaQRlzgAG98YG610RJnVRfrurtoGS2Dha
   VNKRk9xEOUZzvfMvAtqs2TEaSbxFY4ovMlAxyb+YW4tUXJDyEONtBK+eC
   P8LzwChc/usGBCBJWWkkhh28GI7B0QHCeBr9YP13SZhs0o8Xlhmbb/ekN
   Q==;
X-CSE-ConnectionGUID: wE8seMdoQMqh89Bxs2ewpA==
X-CSE-MsgGUID: dpMVZ7vFRjW8CZX+ZRw3RA==
X-IronPort-AV: E=Sophos;i="6.02,159,1688400000"; 
   d="scan'208";a="242529983"
Received: from mail-sn1nam02lp2049.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.49])
  by ob1.hgst.iphmx.com with ESMTP; 19 Sep 2023 20:13:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TSHPdJ7bOCnCkqpDKEtPD4JxgzDKRs4ZReycefpFcXwEWaLvbuJUhzin/riIASMKJmK0+6wByqKfRPnQixi2Wj89rZfTUdJCXQXcRAAPGw+Wgw66fDAD+tG96PT5SyFXwhnPIvxNSclGvBI7SyReF1cwLVxUMidEj9il8VjV5WzcYqlRUta5SDEl+NgRQOj54bvKDzGqTt7IT/GJF0yk5xdSuizqHVeCJOyWUE18q4PvZoMhn5kLg2h7qTmKs8BdxCUddI9iM/ubTY2McDnwBsiX4VuGglhyu1Kb4B003mZKILbpDFDMY/5hjJHIHd7Pe60yX9kVgnPlsynem43mHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UnDYsx/foXL1794mZU+LNc8RMvhKEfWaKC3E6+0NbGY=;
 b=CqqsVvZ/TJkpl9SDVKZgztiMhYbtpVS2PiSV+DafDsPAmx0tNi/rQZCXOI2Domi1a6NplvwokD02WUb1BIiElfeEjb82GyUKhxaz8+IFxF6KC5RPQd4Fuk/D4cBg08hsTVDMeiVauEQuh/+LOUtwBDUf5ZoxgpPfuOBRdUZfaSmnwc6dbahYrSLuBTksGPhSio8safscaKpgWmMZrqlmkjNo/T7bC4MNUW5M0fswPTvHU3HdADqAZxTLDElrn0ySv0TZYnkUJyReSmHIOhjUcE7R/3ODPGrQiH+e02y0YLHQCrADcdINaUPb+5VceyDNBqN5PWcKwDGsgF+t6lni6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UnDYsx/foXL1794mZU+LNc8RMvhKEfWaKC3E6+0NbGY=;
 b=tX4gmtztX5F1IsbJP8eA6QgqavNf2/JO7gjAr1yToEvSEk+pbCLhrIu/BJJK5SnWLXUg1lGmm/cGT/Q71CM/gnBMjULUX3S6k9F06Z/c4x0up0r7ZTqWfYokMWny5/kziH4oftieQNNV9qusTveLvyTDojfePWPR/44mQiVDm7I=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM8PR04MB7832.namprd04.prod.outlook.com (2603:10b6:8:37::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.16; Tue, 19 Sep
 2023 12:13:33 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6%4]) with mapi id 15.20.6813.017; Tue, 19 Sep 2023
 12:13:32 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     Christoph Hellwig <hch@lst.de>,
        Naohiro Aota <Naohiro.Aota@wdc.com>, Qu Wenruo <wqu@suse.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 03/11] btrfs: add support for inserting raid stripe
 extents
Thread-Topic: [PATCH v9 03/11] btrfs: add support for inserting raid stripe
 extents
Thread-Index: AQHZ5yWpOk6Rq2dx+kyAGcccrTCvp7AbEEGAgAcG2gA=
Date:   Tue, 19 Sep 2023 12:13:32 +0000
Message-ID: <5452bbcc-64e4-41e0-aab0-162f5a769fd2@wdc.com>
References: <20230914-raid-stripe-tree-v9-0-15d423829637@wdc.com>
 <20230914-raid-stripe-tree-v9-3-15d423829637@wdc.com>
 <ca55e159-3ce0-491f-9fc3-fdcbab2bcb05@gmx.com>
In-Reply-To: <ca55e159-3ce0-491f-9fc3-fdcbab2bcb05@gmx.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM8PR04MB7832:EE_
x-ms-office365-filtering-correlation-id: 3df0327e-d276-4097-75f0-08dbb909d770
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZxQJxeoOVquhKBcVOX0/Fam755l7oBst7PmxxNQeZeyR2d6XBvaLrnZdgQNIjkP+HaFxAhWsLBpUvvkzy3PXzagP/Xu13qRQCe7KzXMpueUt4yRBEP4mPGTMjO2/5trFJmnPjb8Cdl61wwFDYrPL9AeR39p0a/3R5uVUUY18KCgsP8Ax80F8dWwFpSTr/tuBCHLBgsYXuPNNZYy0s8puCe6zaAynRHSCt2A7a/ym4moFFgQOblTDl935XFVOdpi3pIFO5sSIxAA5Veg+NgOk8jXOFhgc0+MGxGsrJN1Nd5LLG6T8TIc6yxv2PnOiaBgmGAY3U0r2vwvFFRDS3bsYgT+xp5idGZN2JmQBzrui1/gUNdXOKDKxlvQ4qo4ttOzYVXo4RHvDDpuWObodh7qex6aZmxmcrmkFciJwZrpbDBkjl7CbwUwSmO1V90VyC8CdcvrZcuX2XH3W6Os46jtl90aPsnu8LA9CS5oUFPRAqsm9ZDOTCf/bO6oLbOXKwp25gnWEZPxt/RD4LGVWV4G4SGKxJ07tZCBXiD+CB+0z4/SAgYXf74yIddMZk2p2+r7I9d9zq3A7r6PJWB95wqt6wTSOnx9pNENOR1jbEnD+GLJYesBrKeBGT7327KGvi5eYoUBsPKIOCLNA8ZrE2dK9f0r+g15kuQKPJAodxHL7hceWsiZETV5gKZrLvdeFHMuI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(346002)(376002)(136003)(451199024)(186009)(1800799009)(83380400001)(66946007)(64756008)(54906003)(6486002)(66556008)(66446008)(66476007)(38070700005)(38100700002)(82960400001)(316002)(110136005)(36756003)(91956017)(31696002)(86362001)(53546011)(6512007)(76116006)(6506007)(2616005)(478600001)(26005)(8676002)(4326008)(2906002)(71200400001)(8936002)(31686004)(122000001)(5660300002)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dDFiKzdxbTR1V0FZUmxhNmpJeEhtTkdCVVhsajNPbG40VTBHV0U4UVJ2dTBy?=
 =?utf-8?B?dm5Ocko2cWVCdisxK0JrZ2svUEgzbkpnWExWY3Z2aXZQNDhJTnp1ZzBCWlNw?=
 =?utf-8?B?bE5WUHZJTGdSYkVKUjI0UTdBWVV1WnhENDJuSmthaDhPWTFXa0tya0pxNW1j?=
 =?utf-8?B?aFZEbUFiLzNRM2VGOEFScWdqdkpDTlJZZkVLQzFaVW1DeDNvR3Zsc1RwTmhX?=
 =?utf-8?B?K2J1OTJYelZaeHV3bTVCODhobGwzYkp0d2VYM3Y4Qk4vdGFDcWF3K3hUTDV3?=
 =?utf-8?B?WmhsYTVRbnNYOFpiRVVESHl3S3IyM0lLcGdwUzBadW8zRzFxTXRUaHZzVmdQ?=
 =?utf-8?B?TTk4bGk4SE5LdkRBNnZrRnBWaFBEU0hEMEtZUnpPT2lrTEFwTFNDVWEyODEw?=
 =?utf-8?B?cWJoMVUwQmI2ZEZsUTNEME5xSkdEc2xzTVhsQ0syTkttYm1ya2hLckhFcjNl?=
 =?utf-8?B?OHUwT000TVBVQ0tkSEFoUVplKzRacEZKc3NKZkVJWTNub25nNjFvcDBUOHNq?=
 =?utf-8?B?a2w3OTEvL3NNZnJoeXRmSHlCdE91eitlWFZyUHR2VG5zeVFZRVJreDhhZnpC?=
 =?utf-8?B?SGFWZUIwVlZpQlQ2ei9ZdUVWcmw4a1ZvbjlmeGlBR2pNSFArQTBEYkVhTGww?=
 =?utf-8?B?Yk9wMW1hRTJhUUcraFlKMjFycFpZRGdtNmhSM0N1SjduTHYwbVpvSHZFdEhp?=
 =?utf-8?B?QWlFUER4K0lnb0NMWDlCVjJBaGtmcE1aVEtaN2VhVWw0RDJCOXhTV3VkYVFl?=
 =?utf-8?B?RVo2WDVYaTZSblNJVWhOOHZDQVZhcFB4U3pjZk0xbTliUVpDNGhDVFRjdWN5?=
 =?utf-8?B?VUVSYmovNXdQZ1Z3VGFzdmVsVWlFR1NDakFsNkErak0rQllqL29ld1ZYUkV0?=
 =?utf-8?B?VytEcjB1eXpNODAwMDJHdm1xNk11NWJlclVGQUdGeC9xNXJYcXFnV2c3QXp3?=
 =?utf-8?B?dzRQaExob0ZVc0J5SW5aTEljaThCK2VHdGk5M3NuWFhJSk9LZFlRQWhieDhE?=
 =?utf-8?B?eEFEVXQxYjZPOHA5MFBKM0h5T3htU2FYVHdHMDRDbkgwUGVwK2E4VitTSU94?=
 =?utf-8?B?WExad1hmaFRsUk9ESDVSbWdMcS85TzRCZ1VYLzhldk5FcXBLSUV0bXFNSlU0?=
 =?utf-8?B?TWwyS3RyTlQ1QTk0ZHJvVUFTTU44UWZ0R0hnS3hDUmp3cHowSmIxWFUvVW1z?=
 =?utf-8?B?RTluWWtjb0lLZnJnV3NOdlF5bGFPSHZ2ZEdZZTR5bHJ4bUxvTVhWV1VuTzRj?=
 =?utf-8?B?VUpMTElRT0RCMlpueFRWVjhpb2RGckRRaDBPcVV1d3A2TmdjYVhsV0ZrOEo1?=
 =?utf-8?B?UThaRWFiOTBWOTZFaHJUMDkwWllWMXplYkFLMzViYVZvMVNmNjRMZ05ySjUr?=
 =?utf-8?B?NWdjOU8wWDBzNTRhVWo4TWNPa3RGc01HTG0wcEdvYmRhZVZ3YzNDZS9tcVdF?=
 =?utf-8?B?Q1RucWFuc3pDL2xLVGltM2FXa1o4OE9Rdk5kWTMxUVN3ZDQreHNGcU5LMUVn?=
 =?utf-8?B?Vmt2eGtmR01xVzlWSFZUSHJlYS9oT1k5bDRycElUeCsrZDBXbHBPcXdzRXlW?=
 =?utf-8?B?MytRNnFOSEpPK3hvWjB2YURTb1kvWHVTSHBjTllwMytJbEVEVnNFL1QyQUMy?=
 =?utf-8?B?L2s5Y1o0Yzl3am5Bd3NTL0xYZUtlei9uT0ZSandUaE50ZkhjSXZJYmJJc1ds?=
 =?utf-8?B?bkRoTTBEVzJENG5jb3doWmFnV1FYRzdJNlZGQThzY0RMdGtUTG5XY0Rocksx?=
 =?utf-8?B?ZFR2eEY2Z3o2cW5UcGlUOTRObXZVVlVhdDFnc0djQmxlejVDbEpCY2U2K2Ux?=
 =?utf-8?B?WjY0M3pLNXZ2UkhmYnZ4T0RQSFVTdlg0OW5RYmlFN0NCN3d4WXNLK2E5eGxV?=
 =?utf-8?B?UUNScjRDdDJpaE5Td0QrOUtvaTMwQkQvWGtTRnBKMUQzSDd4eGJlMnNZWHZZ?=
 =?utf-8?B?Q2dBRUppTUxHMTFvYkpYakpnL0hxWk1LTG9hWUZUQ085RnpJRmExaXhDZnc2?=
 =?utf-8?B?eEhIYnd2UjNZQjY3dUZTRWFzaHBvRTZEVEtWY3NIWWtsVk5SWG15WmR1emcw?=
 =?utf-8?B?WmtPU2I5a2xvRkRjRWxFRDlTeHJ1WDZZN2ViQ284Q3loMFdkVGNaa0ZyK2VV?=
 =?utf-8?B?TTVnRnRXZkVXQkcrS1huNWNNR0JJdEFmMjBWaGN4MHZNNWNEdnVrcFE3R05H?=
 =?utf-8?B?bFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7A7695E63F577C458F31262A6E12ADDD@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?S1J4dVlZTDBDenR4SWpVeVFQSklaYWNhdFVta2ZTZ1MzV3QxZW13QnV1ZGwx?=
 =?utf-8?B?K09zN2lCdE9aWFFla29EU3pPWGhwZDZHN3FpbC9vQTZ2dkp5LzNNKzQ2UVdY?=
 =?utf-8?B?NloxaHA4b3VQelRabEdlYVNWYTdobTBlVEZJVU5oUFdZaTJudTZES0h3RDYx?=
 =?utf-8?B?b0U0K0U1NXFrVTQ3akRCM3pPTmhUT0c3SXNTelJvb3pxZm5vYVhlWjFkU29l?=
 =?utf-8?B?NCtJTnNCWFB4aHJtWjU4Vk1vWGl0NGVCU0pSVGppUEVjMTlCaUFTSUdTL1Z3?=
 =?utf-8?B?aW05b3lFOFRxaG0zYnlPSUxoVzVaNTdlQXZUazBSVjdYSDNBKzd2UmpyUkNV?=
 =?utf-8?B?alhDaVZMTzZTdElGdDJXYno0azZOQ3YwK09tRjlnWCtUUDYrL1lucmdtSUFR?=
 =?utf-8?B?aVgzeFVWa1VCRDlndXpVVEJBanM3Z0tPQkJaSmdQNlZ5RmRkT0pkWGg3enZH?=
 =?utf-8?B?WXJ3aDdocjVmZG5hN2pKNTNMMWtZU2dpaEsxb1dyK2RmTFJrUTliT0c3Qy84?=
 =?utf-8?B?OTJPVkFYU1pHMWs5V0ZZVTF3VG9LbmNySVhEeC95UzdsZUJqdDg0aWcwLzZH?=
 =?utf-8?B?c0U2OVVHUDJmWkY5bnVaWmpwc3k3aFl6bE9WL0wzRlUxL2xnb3hBekJBMERL?=
 =?utf-8?B?dDZtV3pSN3kxaXErY1YralB1UWZDSHBsWWRYNWlaUWpBclRkdnhMYmRubzNU?=
 =?utf-8?B?TGpqSWlsZGxqVmQ0aGhjaGs3Q2RldUlxTkhEN2NPUVBLY2gxNURoRU9lRmQ0?=
 =?utf-8?B?dktWWlNrbDRtL0lYQlRTbGZKeENwcWRjQ1phSjJaakNYeFhrQXpodktrSDVF?=
 =?utf-8?B?ZzZLcUlaUGoyaEhuRnRWYm9XRTg5TStqSWRZbDdUSUJ2Y1MyTjJFMFJudnF0?=
 =?utf-8?B?WDdMZGw3WFBKYmRsdEpUZzMrMkFOYjA4eGZyeHdSVXVTUUFCZTdTYjVqR1JL?=
 =?utf-8?B?MEVlSUFFbXl0aXhOUWIzZzg2UzBzQU5RSnJ3UUdzWCtjY1RlbElLdzRZcEo3?=
 =?utf-8?B?NmtVcjZVSmpoRjhpNG9Hak5kb2NMeDhMVmNEcjltWVFtalVaMGQycWtvdkVR?=
 =?utf-8?B?SWlGZCtGRjFHTzMvK3FQZ1BoaGhaWVVnaHMrUFNGdmdDTWcyVjRRNGwyM0Nx?=
 =?utf-8?B?WTFGaVVGOTN5UDNTaWxFajR0OTBSa0V3aFNuZE1oSmV1N2F2RGtRUjBKNE1z?=
 =?utf-8?B?MW8zdlhGdDg4QzdmRFJEN2dobnhJcmpJeG1lNm9rajMzSmtCdXVoRW1CbGxN?=
 =?utf-8?Q?n7aYL/hvD5L9umH?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3df0327e-d276-4097-75f0-08dbb909d770
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2023 12:13:32.3101
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x6/0CAufe4FDfhJTHdE4lw+s7md+ctIclNIHtwK7FN6ekMhVF6CL8ur9j4oHDV2hmeqhj7640EJMiIat28ObvAGMbekj4EIVu744vTD0xFE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB7832
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMTUuMDkuMjMgMDI6NTUsIFF1IFdlbnJ1byB3cm90ZToNCj4gDQo+IEkgZm91bmQgYSBjb3Ju
Y2VyIGNhc2UgdGhhdCB0aGlzIGNhbiBiZSBwcm9ibGVtYXRpYy4NCj4gDQo+IElmIHdlIGhhdmUg
YSBmcyB3aXRoIFJTVCByb290IHRyZWUgbm9kZS9sZWFmIGNvcnJ1cHRlZCwgbW91bnRlZCB3aXRo
DQo+IHJlc2N1ZT1pYmFkcm9vdHMsIHRoZW4gZnNfaW5mby0+c3RyaXBlX3Jvb3Qgd291bGQgYmUg
TlVMTCwgYW5kIGluIHRoZQ0KPiA1dGggcGF0Y2ggaW5zaWRlIHNldF9pb19zdHJpcGUoKSB3ZSBq
dXN0IGZhbGwgYmFjayB0byByZWd1bGFyIG5vbi1SU1QgcGF0aC4NCj4gVGhpcyB3b3VsZCBicmlu
ZyB1cyBtb3N0bHkgaW5jb3JyZWN0IGRhdGEgKGFuZCBjYW4gYmUgdmVyeSBwcm9ibGVtYXRpYw0K
PiBmb3Igbm9kYXRhY3N1bSBmaWxlcykuDQo+IA0KPiBUaHVzIHN0cmlwZV9yb290IGl0c2VsZiBp
cyBub3QgYSByZWxpYWJsZSB3YXkgdG8gZGV0ZXJtaW5lIGlmIHdlJ3JlIGF0DQo+IFJTVCByb3V0
aW5lLCBJJ2Qgc2F5IG9ubHkgc3VwZXIgaW5jb21wYXQgZmxhZ3MgaXMgcmVsaWFibGUuDQoNCkZp
eGVkLg0KDQo+IA0KPiBBbmQgZnNfaW5mby0+c3RyaXBlX3Jvb3Qgc2hvdWxkIG9ubHkgYmUgY2hl
Y2tlZCBmb3IgZnVuY3Rpb25zIHRoYXQgZG8NCj4gUlNUIHRyZWUgb3BlcmF0aW9ucywgYW5kIHJl
dHVybiAtRUlPIHByb3Blcmx5IGlmIGl0J3Mgbm90IGluaXRpYWxpemVkLg0KDQoNCg0KPj4gKw0K
Pj4gKwlpZiAodHlwZSAhPSBCVFJGU19CTE9DS19HUk9VUF9EQVRBKQ0KPj4gKwkJcmV0dXJuIGZh
bHNlOw0KPj4gKw0KPj4gKwlpZiAocHJvZmlsZSAmIEJUUkZTX0JMT0NLX0dST1VQX1JBSUQxX01B
U0spDQo+PiArCQlyZXR1cm4gdHJ1ZTsNCj4gDQo+IEp1c3QgYSBzdHVwaWQgcXVlc3QsIFJBSUQw
IERBVEEgZG9lc24ndCBuZWVkIFJTVCBwdXJlbHkgYmVjYXVzZSB0aGV5IGFyZQ0KPiAgICB0aGUg
c2FtZSBhcyBTSU5HTEUsIHRodXMgd2Ugb25seSB1cGRhdGUgdGhlIGZpbGUgaXRlbXMgdG8gdGhl
IHJlYWwNCj4gd3JpdHRlbiBsb2dpY2FsIGFkZHJlc3MsIGFuZCBubyBuZWVkIGZvciB0aGUgZXh0
cmEgbWFwcGluZz8NCg0KWWVzIGJ1dCB0aGVyZSBjYW4gc3RpbGwgYmUgZGlzY3JlcGFuY2llcyBi
ZXR3ZWVuIHRoZSBhc3N1bWVkIHBoeXNpY2FsIA0KYWRkcmVzcyBhbmQgdGhlIHJlYWwgb25lIGR1
ZSB0byBaT05FX0FQUEVORCBvcGVyYXRpb25zLiBSU1QgYmFja2VkIGZpbGUgDQpzeXN0ZW1zIGRv
bid0IGdvIHRoZSAibm9ybWFsIiB6b25lZCBidHJmcyBsb2dpY2FsIHJld3JpdGUgcGF0aCBidXQg
aGF2ZSANCnRoZWlyIG93bi4NCg0KQWxzbyBJIHByZWZlcmUgdG8ga2VlcCB0aGUgc3RyaXBlcyB0
b2dldGhlci4NCg0KPiBUaHVzIG9ubHkgcHJvZmlsZXMgd2l0aCBkdXBsaWNhdGlvbiByZWxpZXMg
b24gUlNULCByaWdodD8NCj4gSWYgc28sIHRoZW4gSSBndWVzcyBEVVAgc2hvdWxkIGFsc28gYmUg
Y292ZXJlZCBieSBSU1QuDQo+IA0KDQpMYXRlciBpbiB0aGlzIHBhdGNoZXMsIERVUCwgUkFJRDAg
YW5kIFJBSUQxMCB3aWxsIGdldCBhZGRlZCBhcyB3ZWxsLg0KDQo=
