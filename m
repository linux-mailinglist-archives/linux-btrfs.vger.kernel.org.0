Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC8979DFA9
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Sep 2023 08:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236266AbjIMGCR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Sep 2023 02:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233032AbjIMGCQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Sep 2023 02:02:16 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16187172A;
        Tue, 12 Sep 2023 23:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1694584933; x=1726120933;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=enJIwVq02ha6BK/TOVCLZ/bdWSPmcV//V1m4El9pKRs=;
  b=eLbJ6ePVazuHVP82XnonGLm+8PaYQSBOLXrRU2yzEqeToacXH/8Sk+JD
   ouPjKfGB90qiQpKh7LI/MVY3y1sBuE7aSMn9M1ZE58+zVwTl2Odgh/JwA
   /UyVFM2v0wDps2Ur5KgOdhYnLvqiFwI1qsVIhyAkM07v8/6k78Ce/M9kR
   MqAwSD11cUrXIjVSjfMovO0JK70pflcWSdk4U9/ieLpcUZbiZNCndOFa2
   DeumjVydsNVvqTmKxPdRgjkNbhxSdeCsp9dVdTJf1vV3VJsilkqdaNtKa
   s42+QTdH5l9TRbDC2WhN1EnXr5GMwY2x7rNs7hTSefHyPXuHHOQG6G+1i
   w==;
X-CSE-ConnectionGUID: O5vqE6iGTeOeoPaqt6WpDA==
X-CSE-MsgGUID: l0/sgi37QtWoRRtcvbcngQ==
X-IronPort-AV: E=Sophos;i="6.02,142,1688400000"; 
   d="scan'208";a="248337057"
Received: from mail-co1nam11lp2168.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.168])
  by ob1.hgst.iphmx.com with ESMTP; 13 Sep 2023 14:02:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R9E/gTyn6SY7/tApw42NtF6X4mXv444o7Y0IF8Z3BYVXyG84g9ashf5So0Ls8uIh/FnyPmumXo+EpOHZRXPnb6QqJefTvNe9VYK9/SXv0P8TKDjNjfEr57VeutZVoVP2QhEo7vSFZynr1vtjc42wuyEKlp2d3Q3vEw6hVkeee1+O7Yg211qsF2PY0pm0+zu1+7S4UIFwcCcFoZTK1qj8pb/GyDwAKouVziVHVnQhCFFGcZls2PeimxIDvxbX8dCcfdNk7iDUsF+lBNcwG14JI+JbMtl3oc3zjlvkfauwRwN+8KhHRyFRMhCnIJURU6IE+GQsoNON+1miOyX0zL18ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=enJIwVq02ha6BK/TOVCLZ/bdWSPmcV//V1m4El9pKRs=;
 b=O+nUZJ7jLgPR8/hp8yN9T4WfKvXufbCUDdWv0dKZJuQLHEfZRWzTgH5MrkYnm8GiirCDyax7lV1fQL0tpJgh1x1WDt7baonGoHF7BjJKrD5eaOi1aQbD4nWUyh8nOTsN9y3Yht5vLGs5SNLn0MJtQQHRhJdU1Fxhk8kEv80mr5Nwj/ZhL6lOBbkY/uHbaIlm86Gx7nZuX/Ti7bXP8/oJvVpwk2Mg02tO3lqJiOmA8sGCKaym3VjGhSx0akIcVbL8KfynRwAyBv1mgNX0ot8JYnj3yA+lfSm07czVJP/ZBQlx9h98UsAs5YSYEgayqlBVJ4puKH81EKbaJNlbwBY98A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=enJIwVq02ha6BK/TOVCLZ/bdWSPmcV//V1m4El9pKRs=;
 b=y161DyYnk61slDcsEwQsKQwM4/j/plp/ZtcMt6rajugi3SJoKWLav5UZTj7dkDKQcd7Np0yn3boinl+uB61drpNYTjoms0E4oZzZP3I6CnwJgrtqd2FdGlDPVkRV0vKgYNlXgKY6/EKAbfU4lDVIVz/puqTz1Dq4Hr8PAakg1G8=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH0PR04MB7924.namprd04.prod.outlook.com (2603:10b6:610:f3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.15; Wed, 13 Sep
 2023 06:02:09 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6%4]) with mapi id 15.20.6792.019; Wed, 13 Sep 2023
 06:02:09 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>
CC:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Naohiro Aota <Naohiro.Aota@wdc.com>, Qu Wenruo <wqu@suse.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 01/11] btrfs: add raid stripe tree definitions
Thread-Topic: [PATCH v8 01/11] btrfs: add raid stripe tree definitions
Thread-Index: AQHZ5K7VvXFOkD3Ns0eOcpvmKIx9uLAXpw8AgACfPIA=
Date:   Wed, 13 Sep 2023 06:02:09 +0000
Message-ID: <50cfa5a0-c209-430f-8c00-54ba41c3791d@wdc.com>
References: <20230911-raid-stripe-tree-v8-0-647676fa852c@wdc.com>
 <20230911-raid-stripe-tree-v8-1-647676fa852c@wdc.com>
 <20230912203214.GE20408@twin.jikos.cz>
In-Reply-To: <20230912203214.GE20408@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH0PR04MB7924:EE_
x-ms-office365-filtering-correlation-id: 656d925d-9173-4274-02c4-08dbb41ef781
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w/CvSD5Kf7yEY/46ZKDEMgmrco8LGuYpBW180A/2cUCl6k4J9EBD/ILk+Xr0NMMN04mixHAz3eLHQTXPBOps7ivul+Z1vM2sf6JeONc6sxusLeID7V2LuS4SPXQmtmnBSmCJxNBE7Z0f+p6fQXcF6t+gmtsWfrCSX7bEdVygrQtGCOeFfmWcFmCiA20Efkv71p7y+Pdu+pJTTp32R7dFkcHeWhHG7IACWR0+YoZ3iXOfVbqRXD4RCaOcuWi2TjpJtAN8Nq15YdWXxtVdpDWSk+Na88Xnj/IZHnn0m/fNN84CMUZoPLVWYDeLgFO0HbXAsmTXHVyFIVBvZbZnJ/xI62vw2P4atgrb2pHwxBCQfqmXWc3Q+ZXBf0W+jNWOfZcO/L+WcWxa8Ol4JbTqP6Bm0QwhDCWtuRRbB9uPE0SWBHM6BqJ1gr4NbVbU+nMd0hBcxL6rMNTVgaU94UsDPmrHrco0drAx59aX/eK00G9mNY+KEZm7BIh+F+f8NQeNFjSFfl30p9vu9O2a+xXnMx3SryC0QuzeuhnqkfLx2taSEpqy6k/ukx4VO96JfYWBS+vsf4uXebiVvHn/hBfxtEBWvI0XOcQRRoKaRn6zWCYJEedRbRlO+OzIllrLYihNdAiMz90FbhSt5/B8kYACjQrd9ia5jrQAea4pdkJeCw/bAOoA2qG4NP97t8wT+iXXcwjk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(366004)(376002)(136003)(1800799009)(186009)(451199024)(6512007)(8676002)(26005)(8936002)(478600001)(83380400001)(316002)(4326008)(66556008)(64756008)(71200400001)(66946007)(66476007)(54906003)(76116006)(91956017)(66446008)(2616005)(41300700001)(6916009)(53546011)(6506007)(6486002)(38100700002)(2906002)(31696002)(82960400001)(38070700005)(5660300002)(36756003)(122000001)(86362001)(31686004)(66899024)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NjlDSEovUHd5ZU12M0FKdzVpNXBpMmlCY0NiaVFvOVIrRGo3dXR6UTBjZ3U0?=
 =?utf-8?B?dnpGQlIzTWJZR25QQzFWVXorSjhGSWh0dktaMTFYTWVEcCtDazMyaURxNXk5?=
 =?utf-8?B?L1BWbStMSFB4TTFmcTdIOVhmaWNhYUZFZEVsRzFjdUlOZHdXWHNPT2xMK0Vt?=
 =?utf-8?B?WVozdXpHbGszWFZ5ZC90dGFXZjhuQU4vZnp2eUNhSE1kWmluc3pqTU9mN05O?=
 =?utf-8?B?bnh2a2xEdkZyUHcybS9UTi9RTklmMUNXZDR1c2hlcW1ZdWs3Uk80Z1ZJV0Nh?=
 =?utf-8?B?bW15d1VZSTJuUThIR2ZSUGhIVEdQcENDSk1jd0ZRSmZhSjlHMzhCYzVGN2Qz?=
 =?utf-8?B?TVU1aFZWbzNoejh3REc5RWRjMlZIejhTdDJQVDRqdHkrREhNMEUweEN6NjBh?=
 =?utf-8?B?TTRMeEFYNXpweWJuaHJQQUdxVWVrcDZuSHZNeXBkSXRsc1M2TDQrdDlpUEZC?=
 =?utf-8?B?SW5FMWM0U09xOWlWckF1dWtYOWtmN0VsNU9xUGZoNGZVdUVTSDNXaU80YW9E?=
 =?utf-8?B?NldrTElUZjIrcVZ0Vk5WMjhKNlFENHhsYkZvOFZjd3NlaGU4NU9hUkphVVNv?=
 =?utf-8?B?a2VGSFNKV2JQWGJMVVF1NDlkcENINVBGQjB5Qnhaa3ZjVzVXeXMwSzJsVmZ4?=
 =?utf-8?B?L3RKWmY0RkxhRWdMdVlUaDJWNE9wTHZPRW5ON3RlQTVaMmJ6bTlnTWZob3d6?=
 =?utf-8?B?R3NFY0dMcU5YNVcxZ0phcXhkbFJJYisxL3JHSlZLM3B5ZjRKTzZTY29TcTBE?=
 =?utf-8?B?V0RuS1RHNzBqYjN3QndtU3k5OE1FMkU3WEkzbGcwTlRxbVlxMngra1JKLzFO?=
 =?utf-8?B?NWlOcDFvVk1uR1duTnBaT210MU8rdkx0NFJMVUVpTzk1ZTRVUmlGdXFUMlhP?=
 =?utf-8?B?RE9QSlhOM2w5ZnNndmlxZWZpSUpmVHM5NWhoTTlIUk0rSjU1ZWZxeGpLOWcx?=
 =?utf-8?B?TGpKcVRRc1g5MXNCYXRwNnBLUjEzekFDVGlnUkpRb1Vpbm1kN2Rmc0QxUGhP?=
 =?utf-8?B?dFRRU25NeTBtMXZ1MzBTK2hFc2JFNWNMRzFxeitJdjJERjY3K2pCWmp3Vm80?=
 =?utf-8?B?V2ZDNTlzNk8xZmtMZ1pUNWhJV3VvV0dVVE9DR01nWVZKMVdWUXdyNVNXQWlx?=
 =?utf-8?B?bmVLWmtYbklUK0toREg4ajRTY0M4bm1CZHprTURpZGhwL2FMWGRNdWlmS0hN?=
 =?utf-8?B?K080aVVpS01OeE41UW4yYTVMNzY4Y25SRlpjTDg5aTY3WVVjYWg1V01JWVo1?=
 =?utf-8?B?RXQ0WC9TZ0MrQ0FkL3Rjdkt4YXQzb0gxeUhjMXo1cW1MOE0zUTlKZ2Y2UE5R?=
 =?utf-8?B?N1lOc0ptdWUvcE1IQ1MyV2kvN214VTZUMHZjUk5mOWhlMWhTM0FRU1dGdlV6?=
 =?utf-8?B?czI3UFkrRU9yWVkrUTUwS2tMdkpGWkplengzYVVDRUtKckE4d0l0dzNQUzZm?=
 =?utf-8?B?VU1TczJORlBiQURVMVZmMW1sYWVkZWZUWnVmWXB3WGhKTnYzRkRnVm54RHZh?=
 =?utf-8?B?aVhCaCtyMDlWckptSjdRUmJWaGdCRXRwWElSMVdmbEJxZC9Wc0I5V3pWbThp?=
 =?utf-8?B?NjlNTVBrSHdYNUVROVFhYmVCTzJjUURpNjVPeTI3QkNsdkZaazlrS3lHN3ZX?=
 =?utf-8?B?c2ovYldlMVI5d0JwZ2dQZzVUTmZSanJxVkl1ekUrcmZKR3h5Zkp1YWdzUGlG?=
 =?utf-8?B?QWc4TEhUUWtENVFPNUJGN3dMVmlaaEZSSDdlMklvMG03QXBEWWo2TzdwbE1p?=
 =?utf-8?B?cm92QWZkQXhDMXpXdG9mNFVJdWVtZHdRTklQTE1ZQ21FZFJ2dzhTaEp4bXVY?=
 =?utf-8?B?QnczcldiS21UY1htWW1rVXhTZ21NZjhlS2w3dk0wb1g4dHM5WG93VVhhVE1k?=
 =?utf-8?B?b0JtazJGek03RkErR0ZVb0Y4eUUyNmxjMGhONHQxbHppZGtjSW55WFMyc2Ja?=
 =?utf-8?B?bTRKRXZjaktBN04wNXZWc0MwU0M1WSttR0xHbEswLytIR0p2aGE3Q29TWHcx?=
 =?utf-8?B?QTZDcWFuOFR3WUdleGVLbHhDUlBwNGdJakJVcUN2K0I4R2R2b2lQVzRxVHo0?=
 =?utf-8?B?VmExV3YybzBmMTFxb29xckdmWndocTJvR3BybG0vdndnQ2dlSTlpUjd0ZFk0?=
 =?utf-8?B?d1JIaldWYUlhTHg2NUg5UTVXd2NJejdGdm10clhKVnZ2blZNRU1UUVkxVy8v?=
 =?utf-8?B?Z2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F8F59409380A0343BCD9E1AC38045633@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?amZoVFk3b3pQRHJ3dEtWbGQ2N3l5M1ptK2o3T2F6WEl4VzZIeTN4bmFtaHVo?=
 =?utf-8?B?RXZsN29meUZxMVZhV3FBVUFPNFlCMDNpNDNxQWVnM3F1eHhVY0UxMFBMd2lQ?=
 =?utf-8?B?ZW5sRFVtMjQ5SXU5aUlqL1p4RTBjUng4cHR3TytLUmVseHZvb1NNVjh5VmNB?=
 =?utf-8?B?cVZIczltWC9CR1o3b2Vic0lwRjRkaXd0N2w1UE8xYWpHOEEwcFBCQ3Mrd1cw?=
 =?utf-8?B?QXlaVDdtV05RTTJSNnl6Tk9jUkk5Y2dzcFdyQ1VrM29jNFNUVlhNR01EOW10?=
 =?utf-8?B?Z3JFZy9vdXpTbFhCaDVOOXhFRmFiTEdQYnlTYTYwV3B1bDFRWXJMQ0Q2SU9r?=
 =?utf-8?B?TDhCZ1RXTXN6V2VUSWZXYVk2OFVXU1NOd3ZvNWh1SU5nYlQrazA4bDNMMFky?=
 =?utf-8?B?S2RuSFEzeDE4WG5TdXR6VVVjaVpBRVZaaDRCb2UrSzNQakV4MkJGeVVMM3Mr?=
 =?utf-8?B?YTNqRlppd21aZW1YYUpPMks1enpKNjR5Vm1yR0t2MDVvMlQ0eS8xc3pLQ01x?=
 =?utf-8?B?Rld5OTcyN2l2Y1oxVTA4KzlGU1NvdFF2WHgweEdtNmQrVmdLMTF2QzV3d1hr?=
 =?utf-8?B?bWUwQjBPS1NuazN3Vmt6OFQ3c0xmVmlnYTBhcDJndXdDWE1NbElEdFJnNTFI?=
 =?utf-8?B?TStRUjI5SWlWYzJFc25nb1FyNzRzY291Kys5dUVYenF1NjYxYkFKVkNhQnlj?=
 =?utf-8?B?VnRjTy9qVXZHUitSTUZhZ3pxZ2tyemNSYnorT296and2U1hNeVRsZ0hpcnZK?=
 =?utf-8?B?bE1uOTZoazhCMXMrTFFkamhxNHhlSmRGV1NGdHhEMDhmTjM5RnBOSWhJUkls?=
 =?utf-8?B?U2ZXL1pPS1ZyRUNTNWtoSzhsSXh6djBwdEFhOHZCTG1tbXZsWXU2a2RrNFNT?=
 =?utf-8?B?eWFuZWJZVUtzOWVTM1d5cFJ1ZTdibGtMQWdoMnprcnhxQU5xcGxUVVJjVzVo?=
 =?utf-8?B?WVNybXhtYkR0WjI0d3RjQkdRTS93aUxaYmRXYTd2MHJpUTBPNmM0aEdGWWw0?=
 =?utf-8?B?MEpOMGUxTk5kUkJaWFZvcTBJa3lTTVFOdDBNSCtiT1NmMUU1UWRWdjlBSFpX?=
 =?utf-8?B?bFRHbDFrWmpHV05Ed3o3S2tIM0I2Y2JyRExPaG1Jdy9RK3ZUZU9xY0ZKZWds?=
 =?utf-8?B?ZUp6L1pFa0JZQUVRdURuRXhXRitoaDdRWU51eVJNR0ZlZTNmdHY3OHNsemVB?=
 =?utf-8?B?REkxZXhQTXlra0o0Mmx2cnh0SnRaZ0dpUFZQSFdXZkpkZnNBYlgwUlU0TW9U?=
 =?utf-8?Q?LIKEZyxJVMWM0R4?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 656d925d-9173-4274-02c4-08dbb41ef781
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2023 06:02:09.7410
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kQ2+qYW0bhfAqNATF4Seiz01sxM8ZJOw+XjaK1COISpc8CIt5IOxSbOQeuaN9WtR6OwDs50POT0IZfwxlMiprmzI9sNxJQopYkYy7hKRGGM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR04MB7924
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMTIuMDkuMjMgMjI6MzIsIERhdmlkIFN0ZXJiYSB3cm90ZToNCj4+IEBAIC0zMDYsNiArMzA2
LDE2IEBAIEJUUkZTX1NFVEdFVF9GVU5DUyh0aW1lc3BlY19uc2VjLCBzdHJ1Y3QgYnRyZnNfdGlt
ZXNwZWMsIG5zZWMsIDMyKTsNCj4+ICAgQlRSRlNfU0VUR0VUX1NUQUNLX0ZVTkNTKHN0YWNrX3Rp
bWVzcGVjX3NlYywgc3RydWN0IGJ0cmZzX3RpbWVzcGVjLCBzZWMsIDY0KTsNCj4+ICAgQlRSRlNf
U0VUR0VUX1NUQUNLX0ZVTkNTKHN0YWNrX3RpbWVzcGVjX25zZWMsIHN0cnVjdCBidHJmc190aW1l
c3BlYywgbnNlYywgMzIpOw0KPj4gICANCj4+ICtCVFJGU19TRVRHRVRfRlVOQ1Moc3RyaXBlX2V4
dGVudF9lbmNvZGluZywgc3RydWN0IGJ0cmZzX3N0cmlwZV9leHRlbnQsIGVuY29kaW5nLCA4KTsN
Cj4gDQo+IFdoYXQgaXMgZW5jb2RpbmcgcmVmZXJyaW5nIHRvPw0KDQpBdCB0aGUgbW9tZW50IChv
bmx5KSB0aGUgUkFJRCB0eXBlLiBCdXQgaW4gdGhlIGZ1dHVyZSBpdCBjYW4gYmUgZXhwYW5kZWQg
DQp0byBhbGwga2luZHMgb2YgZW5jb2RpbmdzLCBsaWtlIFJlZWQtU29sb21vbiwgQnV0dGVyZmx5
LUNvZGVzLCBldGMuLi4NCg0KPj4gICBzdGF0aWMgc3RydWN0IGJ0cmZzX2xvY2tkZXBfa2V5c2V0
IHsNCj4+ICAgCXU2NAkJCWlkOwkJLyogcm9vdCBvYmplY3RpZCAqLw0KPj4gLQkvKiBMb25nZXN0
IGVudHJ5OiBidHJmcy1ibG9jay1ncm91cC0wMCAqLw0KPj4gLQljaGFyCQkJbmFtZXNbQlRSRlNf
TUFYX0xFVkVMXVsyNF07DQo+PiArCS8qIExvbmdlc3QgZW50cnk6IGJ0cmZzLXJhaWQtc3RyaXBl
LXRyZWUtMDAgKi8NCj4+ICsJY2hhcgkJCW5hbWVzW0JUUkZTX01BWF9MRVZFTF1bMjVdOw0KPiAN
Cj4gTGVuZ3RoIG9mICJidHJmcy1yYWlkLXN0cmlwZS10cmVlLTAwIiBpcyAyNSwgdGhlcmUgc2hv
dWxkIGJlICsxIGZvciB0aGUNCj4gTlVMLCBhbHNvIGxlbmd0aCBhbGlnbmVkIHRvIGF0IGxlYXN0
IDQgaXMgYmV0dGVyLg0KPiANCg0KT0suDQoNCj4+ICAgCXN0cnVjdCBsb2NrX2NsYXNzX2tleQlr
ZXlzW0JUUkZTX01BWF9MRVZFTF07DQo+PiAgIH0gYnRyZnNfbG9ja2RlcF9rZXlzZXRzW10gPSB7
DQo+PiAgIAl7IC5pZCA9IEJUUkZTX1JPT1RfVFJFRV9PQkpFQ1RJRCwJREVGSU5FX05BTUUoInJv
b3QiKQl9LA0KPj4gQEAgLTc0LDYgKzc0LDcgQEAgc3RhdGljIHN0cnVjdCBidHJmc19sb2NrZGVw
X2tleXNldCB7DQo+PiAgIAl7IC5pZCA9IEJUUkZTX1VVSURfVFJFRV9PQkpFQ1RJRCwJREVGSU5F
X05BTUUoInV1aWQiKQl9LA0KPj4gICAJeyAuaWQgPSBCVFJGU19GUkVFX1NQQUNFX1RSRUVfT0JK
RUNUSUQsCURFRklORV9OQU1FKCJmcmVlLXNwYWNlIikgfSwNCj4+ICAgCXsgLmlkID0gQlRSRlNf
QkxPQ0tfR1JPVVBfVFJFRV9PQkpFQ1RJRCwgREVGSU5FX05BTUUoImJsb2NrLWdyb3VwIikgfSwN
Cj4+ICsJeyAuaWQgPSBCVFJGU19SQUlEX1NUUklQRV9UUkVFX09CSkVDVElELERFRklORV9OQU1F
KCJyYWlkLXN0cmlwZS10cmVlIikgfSwNCj4gDQo+IFRoZSBuYW1pbmcgaXMgd2l0aG91dCB0aGUg
InRyZWUiDQoNCk9LDQoNCj4+IEBAIC03Myw2ICs3Miw5IEBADQo+PiAgIC8qIEhvbGRzIHRoZSBi
bG9jayBncm91cCBpdGVtcyBmb3IgZXh0ZW50IHRyZWUgdjIuICovDQo+PiAgICNkZWZpbmUgQlRS
RlNfQkxPQ0tfR1JPVVBfVFJFRV9PQkpFQ1RJRCAxMVVMTA0KPj4gICANCj4+ICsvKiB0cmFja3Mg
UkFJRCBzdHJpcGVzIGluIGJsb2NrIGdyb3Vwcy4gKi8NCj4gDQo+IAlUcmFja3MgLi4uDQo+IA0K
DQpPSw0KDQo+PiArI2RlZmluZSBCVFJGU19SQUlEX1NUUklQRV9UUkVFX09CSkVDVElEIDEyVUxM
DQo+PiArDQo+PiAgIC8qIGRldmljZSBzdGF0cyBpbiB0aGUgZGV2aWNlIHRyZWUgKi8NCj4+ICAg
I2RlZmluZSBCVFJGU19ERVZfU1RBVFNfT0JKRUNUSUQgMFVMTA0KPj4gICANCj4+IEBAIC0yODUs
NiArMjg3LDggQEANCj4+ICAgICovDQo+PiAgICNkZWZpbmUgQlRSRlNfUUdST1VQX1JFTEFUSU9O
X0tFWSAgICAgICAyNDYNCj4+ICAgDQo+PiArI2RlZmluZSBCVFJGU19SQUlEX1NUUklQRV9LRVkJ
CTI0Nw0KPiANCj4gQW55IHBhcnRpY3VsYXIgcmVhc29uIHlvdSBjaG9zZSAyNDcgZm9yIHRoZSBr
ZXkgbnVtYmVyPyBJdCBkb2VzIG5vdA0KPiBsZWF2ZSBhbnkgZ2FwIGFmdGVyIEJUUkZTX1FHUk9V
UF9SRUxBVElPTl9LRVkgYW5kIGJlZm9yZQ0KPiBCVFJGU19CQUxBTkNFX0lURU1fS0VZLiBJZiB0
aGlzIGlzIHJlbGF0ZWQgdG8gZXh0ZW50cyB0aGVuIHBsZWFzZSBmaW5kDQo+IG1vcmUgc3VpdGFi
bGUgZ3JvdXAgb2Yga2V5cyB3aGVyZSB0byBwdXQgaXQuDQoNCk5vcGUsIGl0IHdhcyBqdXN0IHRo
ZSBsYXN0IGZyZWUgc3BvdC4NCg0KPiANCj4+ICsNCj4+ICAgLyoNCj4+ICAgICogT2Jzb2xldGUg
bmFtZSwgc2VlIEJUUkZTX1RFTVBPUkFSWV9JVEVNX0tFWS4NCj4+ICAgICovDQo+PiBAQCAtNzE5
LDYgKzcyMywzMSBAQCBzdHJ1Y3QgYnRyZnNfZnJlZV9zcGFjZV9oZWFkZXIgew0KPj4gICAJX19s
ZTY0IG51bV9iaXRtYXBzOw0KPj4gICB9IF9fYXR0cmlidXRlX18gKChfX3BhY2tlZF9fKSk7DQo+
PiAgIA0KPj4gK3N0cnVjdCBidHJmc19yYWlkX3N0cmlkZSB7DQo+PiArCS8qIGJ0cmZzIGRldmlj
ZS1pZCB0aGlzIHJhaWQgZXh0ZW50IGxpdmVzIG9uICovDQo+IA0KPiBDb21tZW50cyBzaG91bGQg
YmUgZnVsbCBzZW50ZW5jZXMuDQoNCk9LDQoNCj4gDQo+PiArCV9fbGU2NCBkZXZpZDsNCj4+ICsJ
LyogcGh5c2ljYWwgbG9jYXRpb24gb24gZGlzayAqLw0KPj4gKwlfX2xlNjQgcGh5c2ljYWw7DQo+
PiArCS8qIGxlbmd0aCBvZiBzdHJpZGUgb24gdGhpcyBkaXNrICovDQo+PiArCV9fbGU2NCBsZW5n
dGg7DQo+PiArfTsNCj4gDQo+IF9fYXR0cmlidXRlX18gKChfX3BhY2tlZF9fKSk7DQoNClRoZSBz
dHJ1Y3R1cmUgZG9lc24ndCBoYXZlIGFueSBob2xlcyBpbiBpdCBzbyBwYWNrZWQgaXMgbm90IG5l
ZWRlZC4NCg0KSSBtaWdodCBhbHNvIGJlIG1pc2luZm9ybWVkLCBidXQgZG9lc24ndCBwYWNrZWQg
cG90ZW50aWFsbHkgbGVhZCB0byBiYWQgDQpjb2RlIGdlbmVyYXRpb24gb24gc29tZSBwbGF0Zm9y
bXM/ICBJJ3ZlIGFsd2F5cyBiZWVuIHVuZGVyIHRoZSANCmltcHJlc3Npb24gdGhhdCBwYWNrZWQg
Zm9yY2VzIHRoZSBjb21waWxlciB0byBkbyBieXRlLXdpc2UgbG9hZHMgYW5kIA0Kc3RvcmVzLiBC
dXQgYXMgSSd2ZSBzYWlkLCBJIG1pZ2h0IGJlIG1pc2luZm9ybWVkLg0KDQo+IA0KPj4gKw0KPj4g
KyNkZWZpbmUgQlRSRlNfU1RSSVBFX0RVUAkwDQo+PiArI2RlZmluZSBCVFJGU19TVFJJUEVfUkFJ
RDAJMQ0KPj4gKyNkZWZpbmUgQlRSRlNfU1RSSVBFX1JBSUQxCTINCj4+ICsjZGVmaW5lIEJUUkZT
X1NUUklQRV9SQUlEMUMzCTMNCj4+ICsjZGVmaW5lIEJUUkZTX1NUUklQRV9SQUlEMUM0CTQNCj4+
ICsjZGVmaW5lIEJUUkZTX1NUUklQRV9SQUlENQk1DQo+PiArI2RlZmluZSBCVFJGU19TVFJJUEVf
UkFJRDYJNg0KPj4gKyNkZWZpbmUgQlRSRlNfU1RSSVBFX1JBSUQxMAk3DQo+IA0KPiBUaGlzIGlz
IHByb2JhYmx5IGRlZmluaW5nIHRoZSBvbi1kaXNrIGZvcm1hdCBzbyBzb21lIGNvbnNpc3RlbmN5
IGlzDQo+IGRlc2lyZWQsIHRoZXJlIGFyZSBhbHJlYWR5IHRoZSBCVFJGU19CTE9DS19HUk9VUF8q
IHR5cGVzLCBmcm9tIHdoaWNoIHRoZQ0KPiBCVFJGU19SQUlEXyogYXJlIGRlcml2ZSwgc28gdGhl
IEJUUkZTX1NUUklQRV8qIHZhbHVlcyBzaG91bGQgbWF0Y2ggdGhlDQo+IG9yZGVyIGFuZCBpZGVh
bGx5IHRoZSB2YWx1ZXMgdGhlbXNlbHZlcyBpZiBwb3NzaWJsZS4NCj4gDQo+PiArDQo+PiArc3Ry
dWN0IGJ0cmZzX3N0cmlwZV9leHRlbnQgew0KPj4gKwlfX3U4IGVuY29kaW5nOw0KPj4gKwlfX3U4
IHJlc2VydmVkWzddOw0KPj4gKwkvKiBhcnJheSBvZiByYWlkIHN0cmlkZXMgdGhpcyBzdHJpcGUg
aXMgY29tcG9zZWQgb2YgKi8NCj4+ICsJX19ERUNMQVJFX0ZMRVhfQVJSQVkoc3RydWN0IGJ0cmZz
X3JhaWRfc3RyaWRlLCBzdHJpZGVzKTsNCj4gDQo+IERvIHdlIHJlYWxseSB3aGFudCB0byBkZWNs
YXJlIHRoYXQgYXMgX19ERUNMQVJFX0ZMRVhfQVJSQVk/IEl0J3Mgbm90IGENCj4gc3RhbmRhcmQg
bWFjcm8gYW5kIG9ic2N1cmVzIHRoZSBkZWZpbml0aW9uLg0KPiANCg0KSW5kZWVkIHdlIGRvIG5v
dCBhbnltb3JlLCBhcyB0aGlzIHZlcnNpb24gZG9lcyBpbnRyb2R1Y2UgYW5vdGhlciB1NjQgDQpi
ZWZvcmUgdGhlIHN0cmlkZXMgYXJyYXkhIEknbGwgZ2xhZGx5IGdldCByaWQgb2YgaXQuDQoNCg0K
