Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9468C65084D
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Dec 2022 08:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbiLSH7o (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Dec 2022 02:59:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbiLSH7b (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Dec 2022 02:59:31 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0015BE3D
        for <linux-btrfs@vger.kernel.org>; Sun, 18 Dec 2022 23:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1671436770; x=1702972770;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=koqssRUc44g9sh5m4sL4xQ3lyMeWf1a9sjR7kia6Sru27C7Cz9GW0E73
   RsYeGq8z4j+/qB4KDNIEF3qdY2Ez7DnAf1XwmRapdnL2WgQrfsdX/PKQP
   tlWyomZS2p+Pvw7T809KTPZ/2lZX37yZVfzUV2ZbFrWM6i3u51oc6V+nw
   kM3FAyk3flJZJTQY8/lx6HDCxhjGO2HFcbmRRMiyJJVI8i78UTv8q1bZA
   PBMp76pkTZAw0JkYy5otdwz4K00Dsk92ZkkhwK65RfsSF/OKPVrVit3I6
   6MQx6KpJRc8BRiOjQijl1PCTU/vcTzqbtyMsYXrK/DwZbuCG+EkjyV8UX
   w==;
X-IronPort-AV: E=Sophos;i="5.96,255,1665417600"; 
   d="scan'208";a="219204922"
Received: from mail-dm6nam12lp2174.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.174])
  by ob1.hgst.iphmx.com with ESMTP; 19 Dec 2022 15:59:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NXVKF+xTA1PFTB180biEI5+gWn/7WC26kC0HB4uttrGYHrXQiLv2b/jkrY3q/sEuu6Wfb73Bz2/dsTJXcYwFQqPDs+B72PHgI8Dv82c+PGkE7w0uMMp/jinOhm6CcQcgowjg1cyiMQ+13ElGhilJz2rRXcKwtVyE4aFpGhKmZMxWb79W1lvMCW4i8IJWGQm6l2O0Gaj2ultQUs2dQAcLKkZ7XChAMRrRq7qV8DRq0098WgCawisBxDMTPno7p2edrkyRjpwaz/QyIgjeZb9naI1bm+cGxd98ZaWlhso8YE/SOaG8TqqOjkfgL4l+y9k05e5a+IkvevDtFSBVCY2usg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=NhuRtplJFun7T/rRc0hqJtmUm5hd94tU1+tr9vqjiidAARC34VSthztuw0RUPUkhAX7QwZfieQtB1RDKnMm3g0PEs2WFsCuHerBnfLsF5McmN2qpOUD5uiPGXh1JR7tMW9Nfo/yw39O16lL7B9ZYC7JDf0no856MWhPOVpK1nn29KQwcwseQJOQgJxqI7XdT85pRwmSc+1cVM03YHYegBVXSQrFstYnsEwvXQO8Bqacmi4f3HxudyprdUIGPSJ5aJozwcOJ4lQ8OzjRMGQX2nc70mjU+zdEtoATMActpg5lTxl/Nf5ijcA41jTMUl09USs2cJSZejevr+/EfjEe4VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=VsS2iP4LKutFg3ocqy3HViAfLJ710y5bv+d/MuL90XKRldT0FKit3qUvp3CBLgQGwcM7+xmal8ZbYB8A1XowjQChfjJhvhPEWzrIj9+CHEatzQW4tOyQHngpdSG8bpnSClPE8MpMJ/rZFIK6/TC2Pgyig4CdrXZN0tPDq/LR97Q=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM5PR04MB0795.namprd04.prod.outlook.com (2603:10b6:3:fb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Mon, 19 Dec
 2022 07:59:27 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f66f:ab77:6874:af4b]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f66f:ab77:6874:af4b%9]) with mapi id 15.20.5924.016; Mon, 19 Dec 2022
 07:59:27 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 7/8] btrfs: fix uninit warning in btrfs_sb_log_location
Thread-Topic: [PATCH 7/8] btrfs: fix uninit warning in btrfs_sb_log_location
Thread-Index: AQHZEYt8+ACqo+rGAkiuZuYGpZ9Nr6503IqA
Date:   Mon, 19 Dec 2022 07:59:27 +0000
Message-ID: <d488683c-b801-12f2-026d-94473435f95d@wdc.com>
References: <cover.1671221596.git.josef@toxicpanda.com>
 <81030329cd7526ec374fa4e76ac6bc4b0ed56e25.1671221596.git.josef@toxicpanda.com>
In-Reply-To: <81030329cd7526ec374fa4e76ac6bc4b0ed56e25.1671221596.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM5PR04MB0795:EE_
x-ms-office365-filtering-correlation-id: 73fc9413-efea-4a09-c18e-08dae196f3c2
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S4xSR/+ctpVZYGPKFeUVEACsPi2OAC0qkKPCtXCL7gCdRCWYa+unsUDfWYujc0U4pkKVB/i1t7BHQz6doP4+mgZQd6qLlmFAU/Lo9eVh5sZLyhlFDhj0DJG4jLaqVBHlLpgvajb6iR4iWTZZcDMTSY8yqkRvaudtTnGSCJBmDGm0hjcjCDl5M9gTt0ZanlX4dgmUFddGVgqmbcgAWTcviWWW4O1wFP68PVUnrzZpmLmGR/B6cLdn8ikJoj0Scd3aoPof0PnUSdvzbyqMTNzkFL91B7OCtOV3VST3m1lY1iKsFl47q2qf7RozK+AjwMmTgenCExXSDc2/M0fjz3HLhG8rcSxTTg0tfE1dE+YGQH3Xxf1YnnowmOTvJUqEtUsfz7AinZdH9Y2JXlNbZguGGoY8YcL2GhoBJmzrtSrEeDHIT/rDOiPrKTNMh0uESxF0Ttg34wa82P3j8GPd2RzI6Xb4Vgf8sYxWlSO15THiQuQJ2+5zzM+sMH6BZOpgnmS1pQ8CQq8j4WgYqMp7ofSpIMdA5IHy4+tha2MfU80apvbuWq/pmqHaMy9FbWOhDPJvEEHc4ppjp6V8mJh0RMUXC/Uw37+vXcqPhh64dVM4IFL6G4chsuVslAjfcQXq/hy9rIP4NEyzhzFm7V07MrYGaJLN3JfUGsFDq8YZ10XfRcdAMn35Qox6T0CWLoKB7+fjlE0ATHe+2rN09lHgHc+qaTcOARcBAVw4QtHP3EiZrXH3NeLVET0GuzLPq+HSMG77AaRA6QwU2X3Fb8z2V127rQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(376002)(396003)(346002)(366004)(451199015)(8676002)(66476007)(66556008)(91956017)(66946007)(66446008)(76116006)(64756008)(36756003)(316002)(8936002)(41300700001)(38070700005)(5660300002)(186003)(6506007)(558084003)(478600001)(71200400001)(6486002)(2616005)(110136005)(31696002)(6512007)(86362001)(4270600006)(82960400001)(2906002)(19618925003)(31686004)(122000001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RWFwc1c4dGlSaGpMcmJmWmZTOXo3eDJ5Wi9TWXBjMDRZOTdDaEpOSVJienVY?=
 =?utf-8?B?eG5qRUVHT2IvejJYcVVIWVlXa1VKU0VJRXFvQm5jQXJYQ1RLM2JyV1lXSE8v?=
 =?utf-8?B?Z2s0OU5UaXpBMHoyRnE3RmZCb1pzeVhNNEowdGZBZkcvdVBTa28rcFU2T3Bp?=
 =?utf-8?B?TFZnZlp3L3F4RTFHQUd3RnUvR2pjSWJLZ1FVU0JvWEc5ZzN6R3FUMGlBVk9r?=
 =?utf-8?B?Y1o2d3hyaVR2elRXUFJJR3MzS3p5b0YyU2VwVC8rMzIwdTZ3TnNReXI2OFc0?=
 =?utf-8?B?YjVzR3RyMTlxVDJObnExSEJGNVV1SGI3N0pZNDNqMVB4L255T2lMeDJYcktN?=
 =?utf-8?B?ZzVHakRySWZZbG1oRWZyNFYvSlhkcmQzV2JoZ1BQTXJhM1Y5Z3hWTUV6cGUw?=
 =?utf-8?B?ZCtDd1VTVGFqaFRyZG1RTnJyN2daei9GVXpiMDIyaHZIQVBkK1pnNkdtRzEv?=
 =?utf-8?B?WGlvNm5TUHlubEIyMmJLa21YT1pXRC9mYllYUXFIK2JlM0MzZkhObG9sUjBj?=
 =?utf-8?B?cThZd2RvLzRackdxY2ZFUW9OcnIxWHZmQTZMUlB4SVRVSncrMHpOdmRVYi84?=
 =?utf-8?B?Ulprck1Ya2tHTW9BakU2RlFlaGM1RU9jcWR0djdlbEczSFZaUW95LzhTZ0ti?=
 =?utf-8?B?MDdhRVJrZGN2RE8vNzg3ZkUzZmNDSDUzdnV6cThoWU8wOTBDZEdPeVhRTVpz?=
 =?utf-8?B?ZnFEaEk2Lyt5R2NQKzc3cXdVaUNoQ1owSVJpQVQ2b2p2dzk2WWZZdGJxTFNO?=
 =?utf-8?B?ZVpUV2dDVXh2YUk4M2kzZXRYREk2ZjRENUlGZStOekQvL0s2NTF1cndHTUxn?=
 =?utf-8?B?YXFjSHVWZHRRWlFEVHM5VnlndVRESXMvc2VBZ2lWVlIvMUkvb2dKbXl5Y0s5?=
 =?utf-8?B?dmgreGdDMUlQRXdRdHM0dWVzZ01XbGlQRjJNZHliUzV6YW8wYklTL0t1ai8v?=
 =?utf-8?B?aGFsMytTdjZjQU9TQVRwa2xHY1MyaTg4c3Y4U0dqSmpqeHdoMzNaSnhDMjk0?=
 =?utf-8?B?MCtrVFJQYVJJWXFqT00rcUl5KzZhVnVuTDdMcDVoVGt0cVJ4dHRzbDd1c3BI?=
 =?utf-8?B?TnRKdGlSZlRjVW1XNVdsemkzczREdVJQamRFVWN6TUVKQUNBeWlLS1hJNExE?=
 =?utf-8?B?RC9mWGJ3UTROUzFJem1YOFBxQjZyTlNRUVRZK1Y3WUt0NERHNG5zL0Q4Y1NX?=
 =?utf-8?B?SkVkTGRHUTljenJPd3Znd0cvQ1hBZ2RkL2tFaFJnWUlxTDhPQU9jZ3M1V1Mw?=
 =?utf-8?B?S3BNQ1dlenBUQ0lJZVlnT2haaGt5UmdmUjIwcVVDZDI5dFowSkdRQzBqVEh3?=
 =?utf-8?B?VEFTaXR0V0R6dVJKUFpLSVFiRHRtcjNGMUxtYm0wblQwMm13RUVFUFNwOFVp?=
 =?utf-8?B?VGlzWGE2L2ZFd3p2dFpYWkQ1UVRwSWNsU0NrS3dqSzZ2K1krWE80U3FZdVln?=
 =?utf-8?B?ZjFMWVZsK20ydjdoK3pwT3pmSHlVODhvdC9FNll4Z0VhVFF0cjhlQXA1MWtN?=
 =?utf-8?B?T3BSVmZGTTZPY3drSGF1ZGNIWE1TclRKVVhQNG9JM0JZOXdDbGM2SUR6NzQ4?=
 =?utf-8?B?NG5XMnFjSTg3eEl6a0h1RDRiOGE1NVJFdTRpaExmZFpnMlVrdVJ6TDl4VzVS?=
 =?utf-8?B?NHplTkNKd2dtQ1drencraWFyOGhzMS9tVXVCVmNTK2JjSWhaRDJYQ3p4bFpZ?=
 =?utf-8?B?RXA2M1dmcG4rNXdMODRxeEVGQ0h1YSs0SU95NGRmK2svUGNlTnZ1OVkvbC94?=
 =?utf-8?B?cFZpS3c1RWloc0JzbFRKTzI1Wnc3bVhqQVFMbEhVbU1HdkNLZEFIYlFwdzE4?=
 =?utf-8?B?S1doS0tsZ2FscVlIT1RMMGFldW9kYkNtbVQrNUZhakNTNkFKSHJRbmNBd3d1?=
 =?utf-8?B?clZKYjFvYTB5YVBoNWszWmE2V1JjeE4xNmhLVWZZRjZRNFRBQkJ0OHFiSG1C?=
 =?utf-8?B?VkpLMTd1Uyt0OWQ2VTVIRzdrazBab2VCSkM3VVpEMUtiTlFqclgxRnpqK2Fv?=
 =?utf-8?B?d3ZyYldyZngrMzc0dG9ML00vTzhnNXU2dkk2N2xhanJJL3ExR1lIVlBLMDdD?=
 =?utf-8?B?T1RDcEdoK2NUN1BMMnJ5TnNxWE5PMTM0STlrTmIwQ1V1QzJRamYyUVNOSTBY?=
 =?utf-8?B?NjJQRU5tbkExTkNWYmkyemlFdUxMU2dFV0UxbUJkNTVwby9sRmhic1FLUFky?=
 =?utf-8?B?S1dFVFIybFU3RXB0OWc3bWtvLzdZTU5pOEJWQWdrSHBIOXIzUnkzcU5rNzUr?=
 =?utf-8?Q?WhE6iMLHGtNiBGGcV8u8SoTol5vz2MwYXVwjcTu6wk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3CA9E2A0D6C069429DCC72F0743B8D14@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73fc9413-efea-4a09-c18e-08dae196f3c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2022 07:59:27.6848
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oMaNQjqJzNOtFlAdmTyvmsR9DKU/dumByInIR9Q0ST1CTH/0yLX77ADPwUCj5HWOE/dIJ4igwI5sPIvKjZA0meRf9VCtj68m5UWz1g5NfRY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0795
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
