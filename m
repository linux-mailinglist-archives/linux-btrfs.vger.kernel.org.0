Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 541EE7C01E9
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Oct 2023 18:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbjJJQqO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Oct 2023 12:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233856AbjJJQqM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Oct 2023 12:46:12 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3CC297
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Oct 2023 09:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1696956371; x=1728492371;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=iuzX0flSugrw7bmlsRThNK+mZjPvS3eIajvbrLX2GI8=;
  b=fWbZ6YfgkZH6a4mhLhiu5hk+D8LKVPbsJN+g5tNm+dMwCkAO8IFRTmm+
   uBNyGLS2whbQI3Res0rWy6/7oUm5EkUGUtV6xn/dsiR+oVzcCQLV/VRY+
   ms33p35DOMJi/6FA/ebK08IcQo+a8hSTB/2C7lNL1cqrEkBXPL3vQaB8u
   qP1OrCHqO+GUUNoV+STK0wIgw9M7K2kS6qiHiZsV3xtuv5Df7ritV9Umo
   jg6hCrcmbw4Qde7pc5vMECAwls04yzTCvyoVWnMoZymv/KgptQGIYL/lh
   kY+srub5Woutg+mf2IT8+i4k3Gkz9nH/Az7PdewCWXwcZs9mwvQQe5YAE
   A==;
X-CSE-ConnectionGUID: kkRTmHaRTMWPQRiwBQ5BSQ==
X-CSE-MsgGUID: Sg0mEkypRNmJW7OFc1K3NQ==
X-IronPort-AV: E=Sophos;i="6.03,213,1694707200"; 
   d="scan'208";a="246196600"
Received: from mail-bn8nam12lp2169.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.169])
  by ob1.hgst.iphmx.com with ESMTP; 11 Oct 2023 00:46:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l2NDCxZRsqtfvqQIH/qIxK0ymheikYkTxKFz6tZW3fy/govrvL4TupELXNufJKNBzrQApq7hj7L8dXxDXaZ7sRAhZjsZsvFUvLZJrxr2eGJzjHiQmf8f+CbdWlBQRe4aJ7ONlUwAUV/8B6pFgXiJMSSeQZwERU5VWzaIrYsOWYY+e9XuJJLFM5Zk3KbqBIoJUVR6bA4XmS+M1nEzangJ7SOryJDZ7jC7fGNb4c6rhzF6+oQhysKnuxJL+yr2EEyRcB20IqIxNEbd5pg+0MtxEY5gxZHHvKFoe3LbMK3Ew4xVX3UIOFANbAGiQi/iEtuYoEziO+LR4nx2v9TtCIQy2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iuzX0flSugrw7bmlsRThNK+mZjPvS3eIajvbrLX2GI8=;
 b=ewEIeXmDsOqC38zwQCJqWv1MRAx1BONYCsVtjbpWE22Y+tIORFljMYrH6XvlsM5Ut6lAfZhrqdFRPRB/gnSVTV677j9ZQ4eGlKcbdHm856myyjpq3nSqYa9megxL9THU04+xDGvosr6QIpU34hG5Jf3L8dSFU64d8OyoRawLh5PatvAjjg7NqaS6ZH5S6YvMmWvGwVhoPJcMWo5y4xbuo2pdOneVfHy9IqENXorqr4W2L8d4qiE9/GOlyqwIYyBpoCZVOJOZfMiKuiI68MrFnNMyw4ZZg4ZXmO6n7XfZ2q9zm0VE9wh8M2y3cVNK515/+bSadWJgvPEcCpsjsh79hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iuzX0flSugrw7bmlsRThNK+mZjPvS3eIajvbrLX2GI8=;
 b=H2HdafDG+4S9U/uLXcb/FjOPE80829SeW20KND3Lw21YdRn3uDyFQ1aPvdhirfixQOsvCPwZRinMoE02JR0a4IzpYdnnfWmZhOVJKtmBtNj+vnPctnlJ1rC+zSRGaF9WCjQ38SOOV0dWbqajUdqROvOB+eiZTlE4RvnATxhEGzs=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SA2PR04MB7516.namprd04.prod.outlook.com (2603:10b6:806:14d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 16:46:07 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::5b7e:bd22:eb0a:2aa6]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::5b7e:bd22:eb0a:2aa6%4]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 16:46:07 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>
CC:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: perform stripe tree lookup for scrub
Thread-Topic: [PATCH] btrfs: perform stripe tree lookup for scrub
Thread-Index: AQHZ+sm8myxTfirAvUSr8Efh0dGx8bBB7l8AgADF+ACAAFVlAIAAMzWA
Date:   Tue, 10 Oct 2023 16:46:06 +0000
Message-ID: <6b5a432a-88c1-494a-846c-63e25e0ceaee@wdc.com>
References: <4895772fd73872ee2cc23d152e50db28a5ca5bbc.1696867165.git.johannes.thumshirn@wdc.com>
 <cdfbc6c3-d43e-456f-9616-441c3b50a1dd@suse.com>
 <77b7ae4f-d353-46ee-9b35-f7eb64bba110@wdc.com>
 <20231010134248.GC2211@twin.jikos.cz>
In-Reply-To: <20231010134248.GC2211@twin.jikos.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SA2PR04MB7516:EE_
x-ms-office365-filtering-correlation-id: 75546f12-b990-404a-49e7-08dbc9b06648
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GdUNjoMtRbvLZfmOzN1Xo0G/B1bpb/ktOZv3P2S6e+BH8sULqPGw1paANmomfky424160+/MA2ThfGRwHnwsNPlW718FebfDysf0LXUPH8iHwXHFTpVLj6b2VmrgLD9ziW0qdoLQIRJ5uUTN14ORfSPLOwWhQh0lF+rw/ab6bHsrO8+U2RhE+43xu2ZGmvIn0LenS75zP2KmO200T0FzhTbT1x6SfhTDTtLcuutFLeNEk8axE0SwCAR1tVqudfrceobgoDDQHHx+sgiOJDo9LFK/StmsQRm2ojCeIoRryzMWo2RBO2hJbN7jFsSdlkWNZb/uukhYncNtIZp1VtS3euXuuBG4g7Aggu7aYNPM8NWbBvG4PrlwsymfE96VaS7/pKboeWfs5LAm2Vv28/FYdF77BZIdJ8an+7m3LZOyQ4QT03nl9bxo9IJEpl6q6r8xfMMTu8Z5+5sLrRWcd0fTXqdkgSOeqqiB1uxLUGJj23hScd+wbg4QHgbIg1icwccX+o+awZIjVQBIk/vQMR966IOJOy/JI+0rWNCzvdp9hqvp5LFBdu1PsFN+HuqToz7+dzKxwUCBTD6bAxdnp8yFWZ/exdBhaVBefgSvtTXEAjMn81OKdVBJI+9yr7hycGFd5JyZsNqbb9pJtb8LSIvJY4RLJat1WWDxDRpePf89TMMN1BopkBAQXcBl5S5Aj+SH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(376002)(396003)(366004)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(31686004)(53546011)(6512007)(36756003)(86362001)(122000001)(38070700005)(31696002)(38100700002)(82960400001)(4744005)(2906002)(6486002)(71200400001)(6506007)(2616005)(478600001)(8936002)(8676002)(4326008)(6916009)(316002)(41300700001)(5660300002)(76116006)(91956017)(66946007)(66556008)(66476007)(66446008)(64756008)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a0M4TUdxWG9kV0EzeUsvKzhpUHhybGJVZTdRM05mazZpMG05aXg5REZVUkhl?=
 =?utf-8?B?SHFLalFFbGN4ZzZGL1NiRXdiS1NhVy85bVllOTM1d0hVSzNUS1FrazlVUklQ?=
 =?utf-8?B?RmZpVDNzNWRqS0pCcHd1allwMjNWSmJoNms2NFRLY1BIV01obE1UNzJENVZ6?=
 =?utf-8?B?R05Za3BNZDI5UVhzWjFpc0c2ejlrb3ZMbzAyaGhiMmdLbUpjRnhpb3BMUUFB?=
 =?utf-8?B?ZnNPcHl1STRjQjZQTlE1ZGpkZldSUEJXVGxwRm1xdGg3d1FaaVZacjNxWGxI?=
 =?utf-8?B?b0NCUFhtVllxUG1oUVdPN0lUZ3pDNm1xd2dvTFdOQjVJU1JDaDgxN3h5aSs0?=
 =?utf-8?B?U004ZEFHRmx3Qk8xbGUyZ2M3ZlJOdVVXYVJocW0ySU9sd2VCYUJSZU9qUFhZ?=
 =?utf-8?B?cXMzU1MrdHRUNXRmVHNXanptTDhMaDlneDlYekJoL0FsNm8zeGVZOWkxc05Y?=
 =?utf-8?B?UmxERGZvbEw5alVuMkErR0YxbFZCUFdTMlJaMHNnekRRVGhTMzNsWG96VW1S?=
 =?utf-8?B?enNMSm9sUlFmWWNtMm83RFo1b1ZLNjcveGRIQU9HQy9Ed040RU5ianR4Y2Zj?=
 =?utf-8?B?OTM5am9tMzM4OXA4dCtiVXA3V2xEQkFYaTRQY2lFOGN2Zm9MemZ2TDlUTjNw?=
 =?utf-8?B?aVBUUGhLaDhrcC80YWFOK1YzSkh6MW9nSEk1Nm1Sd2NQUzY0U0V2S1JkcmdS?=
 =?utf-8?B?d2VJTUtYVzhCS09tYjhFSWRyMWl2UGJJeklpeHBzY2NBSWNuaGN6aVZFZjRG?=
 =?utf-8?B?NFFQRXY3WWFVZkF1VGNZbEpQaTlleGtDZzBrdU5GREI5RVRhWGhGaE80eHRR?=
 =?utf-8?B?Qmtkek9zTVMrc3JLcjM3akdENmFHK0VIOFhEemF6RG03UVI1VEZXUG1SV2w5?=
 =?utf-8?B?QnczZkY5SmVaUUtRYWlrbzhzdjdiMkVqSDJDbkpVd0VDckJMK0g2endpRHU2?=
 =?utf-8?B?a2FXL29hRVkwTUJ1ZEtpREFNNysxSk9VdzNBdE5ZVG1CYlVCWG5XdldCKzJD?=
 =?utf-8?B?Nzc3a3ZudXpTcXdWRHVaNHRoTmVXTk1kYlR5Ty9NM0tMK1p0VGlENGw5bXVD?=
 =?utf-8?B?N1h0YmNOOFZnQUNUL2N6Q0h5RlpaMitQRmY2b1FKcEJnaC9xQ1JUNWc1RDdO?=
 =?utf-8?B?R0Z3VE0zTmU1M2NLdTU0S1NvSzJsK2xnRTRtUFc5dWhHbDBNQUZxU2hxVjFH?=
 =?utf-8?B?WWRQVW1ZNWl3Wnp4OFVCYU5hLzV6NjcwanIvRlVYZlA1elJUUEpNOTZtTGY5?=
 =?utf-8?B?aG55bzBVdmJqdHExcE9lMnlkY0tiRkNFUUtSUFhOYnFYUFdqeWZRSXNTT0ZJ?=
 =?utf-8?B?VlZEQXBIeExwUm1VZUsxV3FWVnJkZDkwZ3JQVDhJNVJIS0lOM2IxUmViY0Zp?=
 =?utf-8?B?RWJMandiNHlzMHRiL1plRUJJREpGQlNaekh6YTMzRVpObXhlb2pva2xSaEJ0?=
 =?utf-8?B?emc5NUd4T2UxaFMySTJOUjBSSjBObEJPR3BpczdHRDdwT3BzcFpEejRNeWN4?=
 =?utf-8?B?UVVEYWZoYzhCOTJJSUxidlBGZzQxb0Z3L1RjR0dMV3FPdk52QlBFZHNXQVF6?=
 =?utf-8?B?V3JiSjl1c3BqU0hhT2VRSkpWc1BJS24rdElQZ2UxNTlhbldyZFBkVFM1UVMz?=
 =?utf-8?B?YityUVYwd0dyQkViMWRDUGNuY3Yvd0haOUtzMFJkbFZiUjNhMENiTWJJdlk1?=
 =?utf-8?B?MlJUVjZJWU05bDJyQ0N2TkYzVG90dkcyb3JYbFI1VzJBcUFDdnE4aUh1KzFN?=
 =?utf-8?B?SDNrVHoycmwrNDEwbzNkTmIwamc0NWVFL0J4YmZvcEwvZk1aSVNkN2ljQVpn?=
 =?utf-8?B?V0lSMFY1MmQ3UU8zNEU1b3lIZlVmVnFuTDlRYkI0UWNpNDVUM3M3ZEtkY3NZ?=
 =?utf-8?B?ZlduYWhrdFB6RjhTWkpwTXJtRDB0SFBFd1NmRlVnS0ZyNlFHb1BEQ1VpdHhJ?=
 =?utf-8?B?aklWWWpNMzdRNGcxVzNIT3lieElDaDE0Y2I3dkttSThXYlZhcXlQNW1HQ1Bn?=
 =?utf-8?B?TGYrRnlWWXRWNERiNHlHT0paWHlXQkFmWjd3TXBCVXFsSTZTcXNJdFIzVUFR?=
 =?utf-8?B?eUVpTzZWc2JkcTBhSkE4Z1hjcVFzSG82b2VkT2srK3JUcFI0d0kxU3llVmNT?=
 =?utf-8?B?SUx6bE5mNDc4b1R2NmJkV0hFOFNNQVJEb3h2TFZZUGlwR1k4OG9sM2NOVW40?=
 =?utf-8?B?UTN5c3FkeHdIZEhveEZtSm1XMHNKSVFGdnVBY2RzRnUzUE1BeTJZa1N1a0c3?=
 =?utf-8?B?YzlDUHZTc0Fxb3UwZGxySTBFZUJnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <833DACF7630CE24BA1EDBFD5A53404E4@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /vBkJgnT2l92DpjM3jaO2pDw3DKLjbsp7+6WO0CMVflQUjGyGpcGSQD3oFSPtL6pNqckk3Y8VdX/JIAKNmyXbZvsDaYww9tREOtD6Bzi+5/oFJdA5tUrsJTItXoBPVHdHfTHxsMYI4N1U/bBIdv0E8SrTQF8q+8fSp2DbK7EfFmALD38UT/ZIaJvtkI6hX5LuRW1TAFrwSSLKckg6aUswfguiUQ23IOIBmmU+ST/kKEYk/vmP60mLVUfUQq4W2ePfVtSUs/PiAgWlzxBqVvjVTWQnRmOqndQxDl8kiMU1qlU773kZ3lnNOpU89tTRZuMv9zOYEIWwF2ZcrfOELVSB9/puUlNiwV2y1whpqxxp9IJwpv/UHaGzNZZzsU7CLED5Vsp/0ODDGXwNa+n7DIDwSBE40ZKOaJq1S0F7fU1t4JrIn453vlcNyL+gEkLS6mUZgpotEDFyQTmssZPTxhHloCS3e7dwdGd4VwErhMNg3+6EervgG4YwFMi61BStXiN+2iDnznasaWa6rBfueaPz7++Kzdk4TO+gRUkegHdo5TbqhRiJroAnksXu+i0F+unpqA/SyWUbil/HApJAf+4RcanZe+gYRrC6ljXtuXu4IOEaPq0aeQy8WQ8Mck2HN4pYGSNlvR0ApmsJgAGOYdlS/1M9g2uA4UOY8DbzweBSgWUkIL4pOcjtmObXx/Hjbt7Ee1LCzI1yfqia33YyZHwCdx7YdH9CFbZPkUXitjSZsvGnZ5WQGEB3RTBcESisdHoR5adtflD/ySOcjn4hacw3Q3b9CS+oFIqE8Joz0KpUuHTxRDsZ2SOgzNDH285vn2VUoElA/ARXQBuBzN2q1F1ww==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75546f12-b990-404a-49e7-08dbc9b06648
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2023 16:46:07.0182
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cC6H5l9inDNBWOFAg2mTTXFy6LFTxjjR24NY9j7jTsvi+PU7ZJbWCfWwdIaTVxYH6rFHSSR8QVBOddH80v7d0pN8m5dHzEO40ahhGmFXy1E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7516
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMTAuMTAuMjMgMTU6NDksIERhdmlkIFN0ZXJiYSB3cm90ZToNCj4gSSBoYWQgbWVyZ2VkIHRo
ZSBmaXh1cCB5ZXN0ZXJkYXkgYmVmb3JlIFF1IHJlcGxpZWQsIGFzIEkgcmVhZCBpdCdzIG5vdCAN
Cj4gZW50aXJlbHkgd3JvbmcgYXMgdGhlIFJTVCBpcyBpbXByb3ZlZCBpbmNyZW1lbnRhbGx5IGJ1
dCBwbGVhc2UgbGV0IG1lIA0KPiBrbm93IGlmIHlvdSdkIGxpa2UgdG8gcmV2ZXJ0IHRoaXMgY2hh
bmdlLg0KDQpJIHBlcnNvbmFsbHkgcHJlZmVyIGhhdmluZyBpdCBpbiBUQkguIEknbSBzdGlsbCBn
aXZpbmcgaXQgc29tZSBtb3JlIGRheXMgDQp0byBpbnZlc3RpZ2F0ZSB0aGUgVUFGIGluIGNhc2Ug
SSd2ZSBtaXNzZWQgc29tZXRoaW5nLg0KDQpBcyBmb3IgdGhlIGxheWVyaW5nIHZpb2xhdGlvbiBw
YXJ0LCB3ZSdyZSBhbHJlYWR5IGxvb2tpbmcgYXQgZXh0ZW50cyBhdCANCnRoZSBsb2dpY2FsIGFk
ZHJlc3Mgc3BhY2UgbGV2ZWwsIHNvIGZvciBSU1Qgd2UgbmVlZCB0byBhbHNvIGNoZWNrIHRoZSAN
CnBoeXNpY2FsIGxldmVsLCBhcyB0aGUgbWFwcGluZyBpc24ndCBuZWNlc3NhcmlseSAxOjEuDQo=
