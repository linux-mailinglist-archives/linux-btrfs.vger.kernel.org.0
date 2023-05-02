Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF426F427B
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 May 2023 13:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233588AbjEBLRT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 May 2023 07:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233935AbjEBLRQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 May 2023 07:17:16 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F4119A
        for <linux-btrfs@vger.kernel.org>; Tue,  2 May 2023 04:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1683026234; x=1714562234;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=TAYpmxiqsTSkSS5RDKQjCbCzdcaosCvrpCgQSES/Uy5qC9QFlFyIzcvm
   UGGblGldTIPFbHc/abrTiroAzkl/ODwr4CAWJLaFeAeUkdYXwXus5F8GE
   QmJh+jOPLUlFlsyJRTlzTUxlZ1J8CiRK71URd+OF6/9NbqCyOWCU8PH2a
   Ej+Pt5LdGB5DICyizKlWr0kztaA3/Uy373kMr/aN4GE0bp2YjPI8vx5qK
   BFhXKahfptd4V+0OE6YZMcItK5kZ6ZcHscqL/IQBW6oPwj3JgGgnrIVng
   iSgTeja6LNpYfN2gfSuOZPJ7IwIAuzUPhhsIgBeMtqQ+1p9/7Kni4tjNT
   g==;
X-IronPort-AV: E=Sophos;i="5.99,244,1677513600"; 
   d="scan'208";a="229739422"
Received: from mail-mw2nam04lp2170.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.170])
  by ob1.hgst.iphmx.com with ESMTP; 02 May 2023 19:17:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kN7FpYWiQ6q+oa32wqytDu1GoHBb0Rs3st/CfvKgW8NqWvYasN2fM39sfv1Xy/0lTGyE8k0cN4t8ZapdSCguXcLU8DPP8ksFYOohrzzZrdKXWfEFJOxGZbzk0e2YSDo0MgEeuOW8JtzBfxxh918xqj4hBmNvTlIJvo+paQFnbjDw/17SXCuawcIN4WbVfw7RLTZvokyMJ40BLYUCzDv/ed+GRfDGaDPtKgF5H+Ppkjqrv6RmO5NiBJsaCVTHjO3J0xMIDBtA6mOPmHOlQAidHWGrK+98SGnqXdDK8LI3hUNWD2De61dlGytQrJIdCNiBOB/Jm1GGWvOW9F2CwuGojg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=VXb4O0AX1cxS8TLSKWY+2p9Pv8ZWG2W8g8X57nB9WHNmdGS0kh88jr2eoqmBPJl1YZa3+bIFyxM8j5K2LTx9mYA9DkUykFmYhRh7gZCuQWUEhRdcAu6zZqIq/SwiOqpCC8oisC/KIVP6YNuAmlTkW9VjKBFejnqDK54IRUFkbBa3avtJeHa6djo2JzM3XhFh4TyCdyxQQnqAEe6/jyw29pJbbYwz3uN6MPZovVl+oaVrirt/woFbMKSucBWgVdXUjGRnYbw3b/5pqOSopNcf7elldLpOK1UNAihMFxEJN57PWnoeqts2ltfF6h0Y6iI3pzC+Z5DwKXqQoHBHGCQnzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=E+tx9Ev8Iawt5D30TWaK7Ic1Ew+Q/C/N11AQpZCQ5PJLZ/RlOlXZ4zkCAv3XRxDbxuXse1AbzA0y0jfC4VbfoGNpfzMvKPxGKtwRLN4i+NMvUdIP6CbsKE2/oQC8XhGeq+aRZEbg01j45e9QCyb2x8Rhrc4dyTS+fz6SZWofvUk=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH7PR04MB8661.namprd04.prod.outlook.com (2603:10b6:510:248::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.25; Tue, 2 May
 2023 11:17:11 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f%9]) with mapi id 15.20.6340.031; Tue, 2 May 2023
 11:17:11 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 02/12] btrfs: remove level argument from
 btrfs_set_block_flags
Thread-Topic: [PATCH 02/12] btrfs: remove level argument from
 btrfs_set_block_flags
Thread-Index: AQHZetZF0TpNIADxW0+FBTRyvwHsHK9G2ZqA
Date:   Tue, 2 May 2023 11:17:11 +0000
Message-ID: <5172b9e5-4db5-67d7-7d52-3dbe2140ee06@wdc.com>
References: <cover.1682798736.git.josef@toxicpanda.com>
 <64d597ef424891ea0f3af9cdbc3284cd222302eb.1682798736.git.josef@toxicpanda.com>
In-Reply-To: <64d597ef424891ea0f3af9cdbc3284cd222302eb.1682798736.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH7PR04MB8661:EE_
x-ms-office365-filtering-correlation-id: 6ab6dab5-4f76-4bbe-8574-08db4afec6b0
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EPQik5C3OF8w6ZErgHOkJv36lVO1sZZQ/D96bDI3z3fST+wx48ljKQIs8BWMqVHYbsPHWp8NRsEkjFFAb0aOi/F7gSEyX+4Ws6gsyTGFWJqjImRFWxI9aeMv7bPImAcUnle7fOzHOq2efeS4NDlZOC6RR25U+bnz3wJPW25mKLmb+gOROJ3IeIzrQfAHABO7gCHW0MFEw9WO+6RdEzzfTqK7SVvJI66vjedRI57mSYzVBVSzCtdMOGr0jHv11rMf+SsFYT+KUDQR+ATJtG5rFCp+XLZadb8LrgUG/NPmZUc9iJWHdYrs2pT/gJhVovZDRIyoWBzylRIvXPClGuMpwn0ONXKEpCUN9/+QeJVKZhMeWjpioFeFCo44AP2UG7ztJQEGbo4AHp+y9vbpLn1VWpo3KF5F9GzzwRXiaekOeM50BMGgPrYLj8LJIyHPlxMW/RHxhXOxGiEIR9NdLQ5swHGJLMv9RffYwKnfyRFQJkyUCwEdWLFLOyQhYW5kq1dIzxpgVg8gjR9NZLoHKLOFDY+ehYT6lba1EM7Xi3kQQus9jjzb9fBqbXnSXczKDG1rftI0N30Grm9I0hyVKptfuIZw8EKw9qFinr5xKSfIG1mRZM8diqaECl7TnCrOdVhj1Y+90pglPczKaE6q//rzIdAcb2PhJu5JIiWVeHPN7GVd7RhjiRm1XRgNaoYxI71V
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(366004)(376002)(396003)(136003)(451199021)(6506007)(91956017)(6486002)(478600001)(71200400001)(110136005)(2616005)(6512007)(186003)(19618925003)(38100700002)(5660300002)(2906002)(36756003)(38070700005)(8676002)(64756008)(122000001)(66446008)(76116006)(66946007)(41300700001)(82960400001)(66476007)(558084003)(86362001)(8936002)(66556008)(31696002)(316002)(31686004)(4270600006)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SWdieXRaenpDRTgwb3NRei83MTRCSTAraldLblkzREJqQ0dXdDU1bzVvNjRM?=
 =?utf-8?B?Njhjb2VhVnp2VUFXL05EZU5TRTJXYXJOV0hCeTJjYnVDbjlmZ1hFbjFvekNq?=
 =?utf-8?B?NkZiZkZaS2NIakFSQjJvTUQ1SlJQVWxTNGpXRTd3SkNhVTRmSjNrMFgrcEZL?=
 =?utf-8?B?Q0ZJSEhYajB5UmthVG9QbUZrWSt3ZGxhMlhIc09TUW5IZ0xyemd4VExrcXhq?=
 =?utf-8?B?a1FiT1FEcUpKY1c4MUdlcVpHUzREN1ppSk9kOTJ1VHdYeENmYUgrRGU1KzZ1?=
 =?utf-8?B?UlBaU0pCQjNDTGE5cEs4NVcyeXhkV1JYdHgwZzU1U1BxWGQ1RktTZ3dRY00w?=
 =?utf-8?B?bERpL2s1clJmbjVpY1dEdWc0bWJpRThnVHZmOFlGMDloV3NnL3hvOHB3UGpW?=
 =?utf-8?B?eGJtaEsxUDIvOFVSbGtKK05vdnpLcExuNDNKenExbjkrOUZGc2l1eFd1WG1i?=
 =?utf-8?B?aktJOHZlRmRXaERBbCt5cjhvMXFEbCtOTTBobDdlOVQ3VlVXNGpybUUyYWlS?=
 =?utf-8?B?TkkxYTJXYzZOelhURTNCRUxnTCtXL3B2bWRtT0dYSHpCcUNSZEhIalBVTUlr?=
 =?utf-8?B?T1FCOUdWcU9XbXdTdTk5OVorRlpWMDQ3NG5DMmg4UHp6Z3p6UW1Rc2ZRY2lL?=
 =?utf-8?B?RDE0V3pSUWFkakpqdjR3VEk2ZVZZT0hjQUphU1JsZDRwRXJ4aWxzcHhUMUt6?=
 =?utf-8?B?eC9JeUFtVkxsOUR0aDVwNWppbjVrTjFFQTdib3ZiWnYzaXFuUWtuR0s4RFVN?=
 =?utf-8?B?M2xGWXVsM1hQL0RJU2YrbWhUa0VkY1BiNmE0SWJldGpzMjYvR3JGZlJITUJT?=
 =?utf-8?B?M1dOd1p4dEh1a0QyZ3FMVGhNdjhRbzFWb3FEQ3owVjdoMWtwMnRaOWlBYjln?=
 =?utf-8?B?azhlc3ZPc1FYTnQzNTBQNFhhU2pVSitnamY5N2VXMlVwc3ZRd1MrSCt6c2FV?=
 =?utf-8?B?NkRRYk1KREd5eldqdTNkOXBicEVwWldyMTRSbWJSY1E1emVIZUtkekJMYW1z?=
 =?utf-8?B?L1Vsb3p1UGRiTU5rRmVkK2dxMHRONXdERkRITDhHSDNPNXRTQWZ0dEp1Skx4?=
 =?utf-8?B?RnVsdXViNjA4NXZHa3NzeGVlcjRQMWphdXk4QWVQME81TjhzSjE5TTQwZHl2?=
 =?utf-8?B?b0ozYnp3WG0yM2R0Rk8zRkpEcGJDZGt6YXBQK0h6TDJzcjlHWDN1dUdPazQv?=
 =?utf-8?B?SmVUb254cmhvcmZRSGUyTU9lTmZtd3N1djVGdmdPRmJqMFV0MWwrSXRGcyt5?=
 =?utf-8?B?Vy9saDFFRHVrS0tReUNMcThqclY1cGF5WElKOWJiRXd6TCtoeG43SmpCUHFu?=
 =?utf-8?B?bUZPMUdCQnVvVXJPRDJTWU5kTmFCdmlOZjFxV20yUWt3d1ZwMU5JMDFpdE9z?=
 =?utf-8?B?aHJ2dXpEZTVWYnNYMGt4SzhaVWhLY0hjaTRSM1haV3pMMDl0eUpDU3d6QjFP?=
 =?utf-8?B?VUJzVFFGTzBlL1l3Uno1b05KQUxzSlJTMDdlbGxIdXoycnBQZ2pEUmU3QWpx?=
 =?utf-8?B?YVRYR0U1YkJjVXVFTE5rVlFtOVM4MjZVRUdkbGdHb1ovTDlVVnEvSXJXUjhz?=
 =?utf-8?B?MGF6RlExUTcwS3NHTU5HMEpFUGNPeUVIaVk0QjFxWXdLZ2Y4dFRBVHNEK0hq?=
 =?utf-8?B?ZUc5ZC9VekRxMzB2aUtHTE5RamFPMzcvMmVRc3dJWVh1eU1RT2J6dWZ5WGRJ?=
 =?utf-8?B?SmhzQ1VrNTFxM1BMS0thZU9ldThVY0s0Y3RJdXVHMEZhY0NLaFVkTGZxL2Vs?=
 =?utf-8?B?VHlWNkt2VmlDN0RpUko3V2RLNkdvd2p5Q1Y2ZjYxdytFV1VPUnMwY2NnMXN6?=
 =?utf-8?B?U1FkSitScEtZTFJEWW1iUzZDTWFxMDBPMUQweUhaQkN6SUV3SUEzNzJkSFVk?=
 =?utf-8?B?UjY3THRmVFVxRktZOGFDb3dDOE5maUJSRUpwNGxUc1ptL1BtS2hKU0tqTUpx?=
 =?utf-8?B?enYrUFdReXFWRS83dTZNUlpEVkkzL0Z5T0tuVlBTbkhsb2pKZlhXNEtHZ0pj?=
 =?utf-8?B?ZFdnNVVDVDRnM2RZQVdWOVAwNDN3WjNpeXRuTktzQ2Q2VktxVFdXTCt6d2Er?=
 =?utf-8?B?TjNub0hndkU2bVRBckd0YlR4Q1dkemZRUnlpa2k4NFVXS3RLSFcvOGN3eE51?=
 =?utf-8?B?VVZheUZuN1krWXV6c1c3SHhUWHF6aVMzSmVXdENMbkxzSnFmMURyVGZTM0l1?=
 =?utf-8?B?OVkyQUx3enRwMk1BZkwrWXJ0cE41eis3aGFtWVJVVFVLOTlERTk2cWN2MzRP?=
 =?utf-8?B?ek5tejNSVFd5Y0w3TGEzNkFOUS9BPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <59328255575A4E4A8C1EAB38F9662FD5@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 80bOjl/UDN5GRAJd39CF3gDn8x2lYHOgLtZNTXTaMZaIM1HUrbu8MU7TjN5H1ig75blIbRn6SsQF+r2Ulug3qAsYrqYtkUaLirP29FeJXtSBgSlIyQeAAxUfgJ/cURLCXJFPplgEwT/zVJWFZR0vBXcvUQmimYjuENnOJAZRcqycVviNiaeh3GN2ton2KCkGaDxxK37F+mXBOiwlZOLSODIxzKg/x92Zff9OkjPDrHAa2pNjoeQ/5EAOJ9Vr/b0OxJYOCVmbneyUd9DxbTabDySyPUrYv5UK8+MYB+1y7XLYg41ss/zw92L/Zcck7RPeHWF4Wp9OJQkTn44loZphOEw6AyuvE/agPelYNxGefConcNr9gjXLCVrEXzZEVKUalFpsychOjuA6+8lGCvlkPrnqJt0sLoi7PiVYprqPr9LjFcpDmKD9iFIdE0XVFTPJWInkR04IpabU578ZlsG58Bg6WINhH9t+O970rUZGor7ruRqqRwzhTYeopPeOV13ppQGHDyOajfwlSBB0VCRl2hbjYKv9C/XXelce4lxxs2rIDF9q9QSEF1TevxJ8brFDXC6ooL1EYQERYkkSl1iCJI9eE8XNnwr935+iqd2v3G+1A6vGzC3dDBT3Nz1KxAvbrVoKQABWALRQS8p1376SecZTM+SMYnEBDFfGk4S1+hxDo62HzkUkOMrH50OsUiah+ptdcKtLa8ZpYQdfnSVrWeQfGetXaRO9Jc0nflsPfWRYnCUO1DqDGiFxmjuULKmWZIbj5Zkb9rDQMhJCvmVRl3O453LYopcd19XoctqJhw7OHBEP2YC7b9UBlW6nK8X9GaLQdoLwdyEuTdReK0seDw==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ab6dab5-4f76-4bbe-8574-08db4afec6b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2023 11:17:11.8193
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2sG/AwXn5qYeMjwvKhDlgsadAc8pe3F6vRhIifpv9G7qlUcxXC0jtZBVwnZa7FxXoyYKUruh4G+5eKjr9MhMnVTJPUKwOX559TuqNMIX0mo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR04MB8661
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
