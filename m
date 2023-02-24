Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 656706A18AF
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Feb 2023 10:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjBXJ0A (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Feb 2023 04:26:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjBXJZ7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Feb 2023 04:25:59 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7EA25E86E;
        Fri, 24 Feb 2023 01:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677230756; x=1708766756;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=VTbCzu5YryyePhEL5sHpup4Yk53uWr0VUElpg9MFqpw=;
  b=pvG3n9xluMoZwKPFDd/HG4+8cIF6E/AQHHdCajkdZBYLYmJwLccKr4M1
   KcP+YH+wTocXPKMixnj2QE+dbTIWZBgqKd4ndDw7mReGMZtmKrCaKgcLB
   JJBqaRwvu/U7ORxZOSFd6FhdED1qTcENX9Fx2S4y8+Vj/XgP+zPi6Wul9
   E9RmUndSQGmF5dsGy7i+hjNEucPpaFwsnCbR4FemROB9IV8qDLiOA8SZN
   J7ECufnMUO5Ui+LqP77/whxsu483SznN+iNxwRmtIZSwuqjKDSYnd1Z8l
   OPIiBqkc1DS7zzy9/ZZP4iT2fykh8hq2Nwqm/7a1qWd0Mr7zld4ElHTJK
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,324,1669046400"; 
   d="scan'208";a="222415224"
Received: from mail-dm6nam04lp2045.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.45])
  by ob1.hgst.iphmx.com with ESMTP; 24 Feb 2023 17:25:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TxElYo6MQvgE6+sOOzgvJJ8MCBN9yS3CIps4PhLNvfcXfykmUf52Je77HKWb5JnVn6YrlVGG3oO9Vs0X8TWSmNesnoWMkVVyTXq/J2NqsstLxsvBp7i3dUZJnnEPTgrXdA1CQGJT9UEmA4Apykbi0TQ+UUcWZ8LthyoWvOHorsnhDxG+w2/mC/3iIgPMnvQ/dS/PSdV196TsJRXLTYZOrIJF9zoqYlXLiJJrh/uuG4ljy7SJZXKKsnMBoVkUK2+PcoAmhVSuTnzW506/WwRF6AX7vvXeSJeoRyIuXnhy5a1bqDeWhLFaOHwp8flpRyhR5U8CEG9wTkhj4wOzefeRQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VTbCzu5YryyePhEL5sHpup4Yk53uWr0VUElpg9MFqpw=;
 b=IoZ50VWuuxnh5Y+hNhAzqIcrnNSiZFKKCEsenP9povstklMxFZUFsaeV2JklNnvlf00T5bFNg+PeUU7NNT7eFkTrddjO/P0Y+wOk39c2HHj3yXcoX3uL2aWPpvIsaxxdC0XTjhM2qKiEgIRoFCGQYYlhXIdboVO2F0WDXtdVBRMF9PM312Wf8ufTxLJsIk3fQN+9xKjJU/P1LAVm/PJALo3BPYVpbkzzCr4crv/TSMmNTDqixNp350d/Tfg6ameoLsNTduNFPxqu/Q4I6Gi+g2SkIA+VepIzrqotX269QfX/TgjHiZ8pheDMM0jyLR3omMQXkpQxz7yIenr9pyL3kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VTbCzu5YryyePhEL5sHpup4Yk53uWr0VUElpg9MFqpw=;
 b=gS40vDRGfJpZ6IFkXOsHeGfV+ha/1wQn1n8wVI6FmwHLuYO/nGZzHa/vjA1Lo8sVfzT3XRpXZu1bT19875n+8WtuTQ36gq/7yz+St4eviAmfaKvwhG+u3q8PqYtHVCb46BfAD2Ef64TZiIa/Mj94AJznPNor9rXVliePRyUsZ1U=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM8PR04MB8197.namprd04.prod.outlook.com (2603:10b6:8:c::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.19; Fri, 24 Feb 2023 09:25:49 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%6]) with mapi id 15.20.6111.021; Fri, 24 Feb 2023
 09:25:49 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Filipe Manana <fdmanana@kernel.org>
CC:     Zorro Lang <zlang@redhat.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: [PATCH] common/rc: don't clear superblock for zoned scratch pools
Thread-Topic: [PATCH] common/rc: don't clear superblock for zoned scratch
 pools
Thread-Index: AQHZR50zoLOS8b1oxk+LyVydkDFMUa7cwaUAgAETF4A=
Date:   Fri, 24 Feb 2023 09:25:49 +0000
Message-ID: <e7b51926-b8ee-6c74-aacc-badf49b7ef93@wdc.com>
References: <20230223154035.296702-1-johannes.thumshirn@wdc.com>
 <CAL3q7H4gkVfb03+SB6-FzxFH+6aVu2MUM9ZTRVhYi_8d7m4+ig@mail.gmail.com>
In-Reply-To: <CAL3q7H4gkVfb03+SB6-FzxFH+6aVu2MUM9ZTRVhYi_8d7m4+ig@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM8PR04MB8197:EE_
x-ms-office365-filtering-correlation-id: e3c53900-8737-4bbc-19ba-08db16491dfd
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P3pdrshgh4ZRt5joVWW+YVRQI8/Iw8qrtBf7ydyqudmiWFw3b6zUEhMlgZAOPTjvp9OjTKLmn8IPGLDd0gY6fC4bGBauThnz50ccZ+GBbB9YyxSiXxCPIaXZb7i2taVgsFdXALq6Tgs2G6NqeXoaWqE6HylSXHgSTFG0zdcNQBLVWy1iGph/cBKwmygzgO5pYlS6/oJlP27VCsPbEr1nOuVHfPEx074Ni3dDTyImf8iyDlPWEb0rvLZJqdJpGEPc7Rcr3/j8y9rJ2XG/c+N/bc02kwadNJmjR7fgIh3KqGfi/LPKIJv+8DVpSpII1n6KMTeokrdLQ4mvl4LGqNVEnri1Tt2qE8XQl9/UA6ZvbQhYPwUY6L+EUmJMfsFNRIfEvFct/QqnKYJhc35yvMu4cZcPa81kAJVaofHC6KO39XpngiB8Sj02ZosjJCd12z1M8KrH9LMrMOUivO1r+0MhcIBsYn21EW1rvgy0EjfLtey/63LjgBggIlJvcvXPA9kxPcI+XLr97ZcMadv+g+b47anXRO90tXuwAKtv3uCktx7oWC9Qp8H/Iejy6zY5hAiCZQfaHMV93AFyCTM19cE6UOggE2yuOCo49BQHhj9Pa/B4IB/FcaskWmhOt+An7fFhPuTErw7SMENC81RGue7Rfv8ijg1B8ULi5Nn6ZhTd5OCY0YpCuNP2hdJNvlVjRu/ZPc3plKIDrrZNnn1/WY7bf7/fFGHxJde8+PPrIY5GrWuSusWzh5o+ZsVs6aptROrf1n4UN3s5AjgK/0zdzTO6Ug==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(396003)(39860400002)(366004)(136003)(451199018)(478600001)(71200400001)(38070700005)(82960400001)(122000001)(4744005)(38100700002)(86362001)(31696002)(2906002)(316002)(54906003)(41300700001)(36756003)(5660300002)(4326008)(66476007)(64756008)(8936002)(6916009)(91956017)(76116006)(66946007)(66556008)(66446008)(8676002)(6486002)(53546011)(6506007)(6512007)(31686004)(186003)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?blN2cWQvTVRibnMrWWJORUg4WWw1dmZVMjMwV1hRd1RkL1JtL2xoNDFZTnVE?=
 =?utf-8?B?bmViZUJhZnVGS21HR0ErVmczREtiQ2JweitUTVF0eFBxYVFIeFJCQ1Y5YlFW?=
 =?utf-8?B?QW9HTTRQaFM5aUtsZ3ZXZGlKS05XczVmcGJiMDNOT2JPU1hBT0VEdmJGU083?=
 =?utf-8?B?ejZFL3lENUw5VWtyN2h5SHhPK2pteitWdFV4NXl6Qk1kcWNYcE5YYjM4ZGlJ?=
 =?utf-8?B?UXFlNUEvV3dWendOUmR0STZOT1FScEdMaXZCUitnQU9mWCtZMnVFU0U0QmZE?=
 =?utf-8?B?YVZZOCtuSU1VbC84QitscmlKeXRHR3hROXo2SUhKakV6aGN6R0VlcEhQRUhC?=
 =?utf-8?B?a1ZZY3M0ZmIxNDlrN2xRTXFLTG02TlBPNW93ZTJ1Rmhyd0kwR09JZ3M1MHR6?=
 =?utf-8?B?MWh1Y2p2cXpNanNvQnhVMXZVYjNOa0ZKMkZoMzVtL0syN1M5ME5mWVVZSWdZ?=
 =?utf-8?B?MjhvTDdtbjhuUzZkaVF6a2QybUtpaXY1MVBoS3p1dlJObVh3SzBnQnN4ZFFG?=
 =?utf-8?B?OGp1YVRRblNQWmJUU3NKS05yQzFqL0x6SFptRHRHRW1VekdsazBSVjNWR25r?=
 =?utf-8?B?VlNpN1VCblpZajgxMzZ6MGVxeFVMTWlWTmY1TGYwWlAvTVREU1B0dEFTV0Fv?=
 =?utf-8?B?NnB6c2g2dzVNbWNOVUdJTlQ1WUYrT3ZENHZmZHNLUldCK2lDVkNSUmh1eVdM?=
 =?utf-8?B?Y2FaY3pKSHRyNGtpOTNyYkQrb1A4U3NHUHlvYkVOeTBqUlRKb0wzZmo0Wkt1?=
 =?utf-8?B?WFYxbG5IbEQ5Sk10UUR2eFBVOWIyQmxLMjF4NU83dUl2dGh4LzR3SE5Ha2dM?=
 =?utf-8?B?Mjk4RGRpR1RReVBqY2d4djVyL0FFZ0NMVjAzKzlHeEJidmdkOThVNTZlUmxQ?=
 =?utf-8?B?M014V01RR3hQN1lUbnBEczNHcFlWczdRVks5Y0pLTU5oWlZHTVZ3ZHcwUXlw?=
 =?utf-8?B?QXR5ZEhqMnVOYmJrR20xdDJkZk90RU80eDJqbHJQamxkclRpUDNJNEdDUVZi?=
 =?utf-8?B?d2cyUmxRVk9Bb2U3STRtSHJLNTlXa0MyaU5KbDBHRlptaVZzcHNyT1M4NTR5?=
 =?utf-8?B?YmlLNUVDaW5aanVoTHg2QXhNUzFVR29zeXRIdFg0VWgzVGtFb1FaSkJhL0JM?=
 =?utf-8?B?QmVMeXMwNjV6QitEMFBnQU5kS0hDNkZLZ0FSU3Q2KzI1V0JtSFZXVDI2VFc3?=
 =?utf-8?B?bEY0Mzc3dHZSVm5yQXRqVTh0S0xsa0Q3TC95K1k2YVl4YnUySWUyd2NycVhy?=
 =?utf-8?B?cW0wRGVGdndCWnRoVWVPSFpSa2pBZ2EzSHR4dFkraUd5UXZnL256dXg4RkpN?=
 =?utf-8?B?RWljRFlacDZoUFBVdzlKQWM5ZENyNlVrenFGY3JUaDNPSWlzQm5YU0RSRDFS?=
 =?utf-8?B?eWk1SGM5cW8xcXpCdmFNcjNpYURmNE1lMzVtQmhaOXJIc2dCZ0REN1YvTGow?=
 =?utf-8?B?elBmbzZYcGIyb0xHZFVYbFZ5QncrcUtENzkvRHBweTJaVmdzMUw3cWJJRTA4?=
 =?utf-8?B?dThGK2xLclptY2RYb3V3OXVIL3ovSE1CRjhWR1FtMFFSZnhkS21La2ZyNFhD?=
 =?utf-8?B?QVJqRjJIQ0E1V1FWZThGQnJaSUdIWTJlWmR6aWF5SHZvRndJNTV4TWEvOFBG?=
 =?utf-8?B?dktjT3hjTHEzYStuQXgrWVhWMHhhTmx5WmpWNkxLOWdDenZoUEthdml6a1NZ?=
 =?utf-8?B?c1dqaXJDRGErdDNzNUszSnhvZWJDcVRYVmhIUU1SRmRiY1N6R3FQSGhxNHNx?=
 =?utf-8?B?RldZeDlVUm9ITTJXZHR3QU4xNGxkL1MxN3FxcGprRVhWVVNFdGc2c25DZEZM?=
 =?utf-8?B?QUFiMHpyQ1VxZGx6N3RFZ1BxZ2Z0R3h4QjZBeGljWGdoN2NTWmhhNWhWcjRC?=
 =?utf-8?B?OHJlN1ZDeExlVEZySlZPY0hVazNrZ2p5cGhweEkvNkdoZWQ4MzJuTlZVVS83?=
 =?utf-8?B?WFA2dEFYcDRmWFp0REJndU1QV0FhbllQTkVOVHlBbEt1WVJrMjFHTFBZWlNS?=
 =?utf-8?B?UHh2ekEwYkl1L1JZWFZ2SzBrZWtyc3pmMG5aVkxwOFdLb2wxYW81UXhNK3RX?=
 =?utf-8?B?T21JVEMrTmVxN0h4SDk2azBVQzEzMWRxNlErWHZvMkVzaDdyWWJLVzlpY0ZW?=
 =?utf-8?B?VkpNYzFKMWYyM20vM0ttOUdFb3p2MzRkRFdLNDAzY2tMSHJrOWV2b2dUYjNs?=
 =?utf-8?B?QjM2aFY0cXhmU2lRQ3kwcExsWC9qYWxxa2Nya3VVL3ZhNnNjM2wwWEh2alZu?=
 =?utf-8?Q?Yy8h1Gj2X9uvPFYM9qfC7VECsKyfKFd3evajZFQYg0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FADF0E7252E73141B315B5BACC9770D4@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: GA/pSDWlcrOIBNznrG/hSobkD4qNX/AxhjjeKLKQkF6UVBNX24e/wUPzu44s+VVorN0TKVHC2gLb8b1mZDpApWP30++LWb9bLd/9fGQTgGOOsHiS+SwA04EPnRM5iVKVV3pgnhpFLC1Y1fN+YRRBv6G1BLhQ3S33eWwLoIUbhrIjVMGepl8fS/IUicvR1MQdd95QS3+yJ5Xfz4bQKeLLzIkqDC3qhnUdhqM4Pis9BOtagX58c9TUFwtIKe+v+YOGjAqhU4bcU9hf/ZFiK6MWXTwzUgGWiCoq+Os6w5I5FktxlFmCYsdFEIINhBiEsbA+8rz3KWSJitkfDTxhvxBUyAzimbaeQNpaxkE/q8I/2uZsbBu9btnzAjm70IDxDaqEzIncu0no8DayZgqAX6Tki8gtM7f/xzc2hjrlrdFMVKq4ymUaxuDL41VQOlEHU6BX8BA7dpRdjZUgTSfntlMQC4OY8PQeKelncKlEHC8bOdctFy32KMjDx5gFXonTOlNAwMSAg49KuZSUtsm1PanPeUXvdtVm4/Gnb0zkP1zmKF9rjyz6j12gF9XyWQ4lG5YphCs7//GdcnO4DxEGBWDnj9YU7Ks7Mq8XtvHFKbkQ5uUK1VVZp9WRkx8Mkc2ql/rXJEoce5CeZz0fIadb270uPOk2+hHQS3+hmpzPVo7HNMpL8J7dBb2iX1YzpvQrdxuVY9naSXCPRCNQ1oJ+G4uJny395SDDFqFRwEdEocQ/SmlmOhK9g4nPcHFJC9qwDtTcBFFhHQRXVsFMA9kFJdIqUfBacSXYySieLWujlLThmYDnck5x7QRhn7Jr6QNEi6Skn8CFuQy6NCVlhnYdTL9PBQ==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3c53900-8737-4bbc-19ba-08db16491dfd
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2023 09:25:49.4451
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LySe/MPuTHKi/Po32lbHxY9jDqYbq0F7a8VyWPb30JlqkJChLYWfH9zZzAfB8vY+tvSLXGCtygAKhKgAWUIQ4OGVlV8UWQaTLRM7y2B7QIM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB8197
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMjMuMDIuMjMgMTg6MDIsIEZpbGlwZSBNYW5hbmEgd3JvdGU6DQo+PiBPbiB6b25lZCBkZXZp
Y2VzIHRoaXMgY3JlYXRlcyBhbGwgc29ydHMgb2YgcHJvYmxlbXMsIHNvIGp1c3Qgc2tpcCB0aGUN
Cj4+IGNsZWFyaW5nIHRoZXJlLg0KPiBXaGF0IGtpbmQgb2YgcHJvYmxlbXM/IENhbiB5b3UgZ2l2
ZSAxIG9yIDIgZXhhbXBsZXMgYXQgbGVhc3Q/DQo+IEFuZCBpdCB3b3VsZCBiZSBuaWNlIHRvIGNv
bW1lbnQgaW4gdGhlIGNvZGUgd2h5IHdlIGRvbid0IHplcm8gdGhlDQo+IHNlY3RvcnMgZm9yIHpv
bmVkIGRldmljZXMuDQoNCkl0IHdpbGwgbGVhZCB0byB1bmFsaWduZWQgd3JpdGUgZXJyb3JzIGNv
bnNlcXVlbnRseSBmYWlsaW5nIHN1YnNlcXVlbnQNCm1rZnMgYW5kIGZhaWxpbmcgZXZlcnkgdGVz
dHMgdGhhdCBoYXMgX3JlcXVpcmVfc2NyYXRjaF9kZXZfcG9vbC4NCg0KSSdsbCBhZGQgaXQgdG8g
djIuDQo=
