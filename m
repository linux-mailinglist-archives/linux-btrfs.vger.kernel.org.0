Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5991E69E65D
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Feb 2023 18:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232813AbjBURxN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Feb 2023 12:53:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234825AbjBURxK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Feb 2023 12:53:10 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47EA627D61
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Feb 2023 09:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677001988; x=1708537988;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=Y/vLw3OTQfEK/mY2x5BXmbs18yS3TTjE6FRNDP/zGao=;
  b=Ns7oMgNepqdft6D46qZP3DWh9Qz+H0bmAvVCu/jLVw2wPbvr+QKtfQPl
   SYOgYeRQg2SCuQU5JHIGX2YEFEz9KRBw0KQQvNt6a8Zt2Qik/YUpIEIBC
   iuRukzLZB/bHGN8jjzvbxgCUGyRpP/pvhQjpRmvHT4ZWWvQ41LDuP2G6j
   RpABqQ0F9aWIXSAp2FCAKVJEeJxsls27PnIEr7EOv+WZjR2yvjascrNVI
   OgCrlUHmCIa9X2BMAd8A2aXvtzt7kMU+CwxMKxvVDCKiHRDytn5EBVCKP
   b6cbtCXY2PGJHIVG6RBb6unG1HK8UnkKhuCqrl+9KQYcbDkE0dxS233tq
   A==;
X-IronPort-AV: E=Sophos;i="5.97,315,1669046400"; 
   d="scan'208";a="223838817"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hgst.iphmx.com with ESMTP; 22 Feb 2023 01:53:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FMnGurFv3K+5MGiSRcvuq5aKBxXHcF/7RG2TPttNWUlTtiLLx6btL9gdQiA52tNlEL/13cnSspGikr4fOMiq/TgL4oJiGsfv+lOJoee6RT//LypLoF+v9lG8kImcyxR/wgy70oQ0UiCzZTBmKoVGF58/iqxOguxwWfXofU9cAgKX6S6nV68ifFxsCns/80daluAT5tEil0Temzb1TX4cDkssfss/Ufy32xIYgvW+nQk16cMulR0r54OH7U57UB4pgLytDfw+/ewDvowyCgtYoQSjpH7kdZGiF4x6vnm/pvpuW65apV11fjgEUO7wNxMeW/db9n8lrem96PeJtWC1mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y/vLw3OTQfEK/mY2x5BXmbs18yS3TTjE6FRNDP/zGao=;
 b=cFOvzYoje0mKA4XslwRrPeOw3c/i9vrZun7pokikTa7Zv2vXd9GoXSEO/qgaJZZ6Gg7GgyQECEUgIeNYzSwi7g4UufUkUkLioqM8bwVoSxel0pGOw8zXHiwp74hLyvwlvNcs2yo4GJBFZBU3kAg/ii9Wx9Od3hbzZIkjWycYfBOo4Hg7zbmnQnOdx969TBo3q/ujH6a58880gEsY+WlbVeUqXfUe8nWxh4SBvL4lQcMzxrJS8kjZuRts3xO9Jm6iGQP9aVa9l+kzOJ9mCdnUIpLcgj/UfoqSGiCZrOUI3CWVE/Y2BifhKdDpwwVG6PF9ovWacdVUBM7N1r5JRkq0LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y/vLw3OTQfEK/mY2x5BXmbs18yS3TTjE6FRNDP/zGao=;
 b=glxjiG084WhiRCuRWMkdwJ62Q1RRazBtCZPF3UlW8jT52wvx2niZRhOgpVi7nhMJpWI7jow/HE40jiB2hLjwym2Xdmb4fZSyMJvEkU91TP1DK+gxx4YX2/eIDoseS/+suKcRYMMnxUbEm+7h1DI2chUPdlLAnnNgGQtd1AiS5R4=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN8PR04MB5842.namprd04.prod.outlook.com (2603:10b6:408:a8::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.20; Tue, 21 Feb
 2023 17:53:00 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%6]) with mapi id 15.20.6111.021; Tue, 21 Feb 2023
 17:53:00 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Forza <forza@tnonline.net>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Automatic block group reclaim not working as expected?
Thread-Topic: Automatic block group reclaim not working as expected?
Thread-Index: AQHZPG2akAEfAE1cFkyLx/ChHDx+hq7Ga+4AgABNQwCAACr1gIABF4gAgABQOYCABcrbAIAAcqwAgAsgAwCAAAu7gIAADKSA
Date:   Tue, 21 Feb 2023 17:52:59 +0000
Message-ID: <6a3126e7-6f35-3d6b-81b5-e0c519beb2a2@wdc.com>
References: <e99483.c11a58d.1863591ca52@tnonline.net>
 <b508239a-dd7a-98d9-d286-7e4add096e13@wdc.com>
 <2563c87.c11a58e.18636bcdf0b@tnonline.net>
 <31bf44b.fe8fe284.1863749a10f@tnonline.net>
 <f6e2f95e-0892-f82b-43fa-34ef32f19320@wdc.com>
 <b19674f0-0743-4e34-df85-ba6c458af01c@tnonline.net>
 <73b49250-8aaf-bbb7-92c6-73e0ad3d707b@tnonline.net>
 <60d348db-822b-c337-4c4d-edb06094302b@wdc.com>
 <3a6e20d9-2fc0-840a-18fd-e604f65d6d7e@wdc.com>
 <571c5253-5368-e453-42d1-00f44d2a1709@tnonline.net>
In-Reply-To: <571c5253-5368-e453-42d1-00f44d2a1709@tnonline.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BN8PR04MB5842:EE_
x-ms-office365-filtering-correlation-id: 2c9dead2-8c2f-4ea1-9999-08db143478c3
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U/DRziK/7FmDWbilvInJC42LZt4HPTSZsQQyOSERJ+SfTgJv/55OhMfQOO95o9BH2l35oC8eob+4s7PO6xYIrPAhH5Jz2m6Psdws2910sQx4BQ4Ixn1O70T/Kq8dP6cwZhzsfPC3W6UOUcZcyOshlfjTdmjn9c2MursiaqFFVHU9bhSrAqNnUS4rgkusPnLgHmCNY4uSufTDTfrWutVUjKk0Sr3bvfOK2BO3Q5Y8mvZcNeb/BC2vC4J6JwGpQjMJvi65DMzfjAFkBvY4bdkxZ3r3Be5UyBbunaW0eJxrc9+0SEafB5iQHPqWfCvfPLpmtzKaWi35WiWgXCSGfYmHVvIIRqgELjpaZV3zIsnd4tMLal46iiFRVjNpySwOA8+J9pH73L12HkgONW9XekCR1Sqq3rZ84oVjtHb7dGshpkFgvQoaKI0OzBoWLh2p8N1wjdCsAMSHzpbN1McAAmowkQPpqYoUvZ7D/rq2lORL1/mEhG0UL3yZYcAlkKSi8a4zVsjdCMCnspuWo/oFct4J2kxPJwV5oYmzqrDdnLdp26f8ZtJRk/jFgRNppmtS0BF9jhtGqgTLmG0SQJ5XTCGHo9+0AnWL81Ygu1O5A4SRsbiC44QxXS2myCqZcp0UVmIJEKDpqG3UfyYXzG1aPkJciHKm8jY+loDeIE5werqO9vmlRR7MmVYEPELf69Fg3Ovg4jkUDFRCUBt9KN3b/cBTK8Rr6N+rlsT9ePHpHiB/u0RTlNKExBgkFoVjCJAPTbbirJSOsSz7farmBIiXzWjDWg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(346002)(366004)(396003)(376002)(451199018)(38070700005)(2616005)(8936002)(83380400001)(5660300002)(41300700001)(86362001)(71200400001)(2906002)(6486002)(66476007)(6512007)(186003)(6506007)(91956017)(66946007)(64756008)(53546011)(76116006)(66556008)(316002)(66446008)(110136005)(8676002)(31696002)(478600001)(36756003)(82960400001)(122000001)(38100700002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Zm5zMkNLSDdKVUpQdHlPbDBNazMzU3Jhb3E1OCs5SStJUStVRENjcStjUWY4?=
 =?utf-8?B?SjFJaHRKbUtNTkJlMklvdkFDb1Zpc2JQWUhVRlU4bGRwWkMxVE9rK0h4SCtx?=
 =?utf-8?B?ZkNRVnJqWTJBb2gxSmhUbGlCUkYybjNBbzQ4bEtwQmd1dEJuWGYyUS91alEz?=
 =?utf-8?B?Q0xCUWJvSWxBWFNRWTdQVUtwd2tIQ1A3MlB4SEZ0Q1VwMG1iSzcyWnU1UWhp?=
 =?utf-8?B?aFZXaTR3QnJybXpKVld0RWhNTlBiN3JpU3ROVmpLSktPcHJveWZtU1FocHRC?=
 =?utf-8?B?TUpIRnNQTjd2Vk54cUppayt4Wmd6TDczdjJtYUl3dTdraEtuVFJSelFVTVJs?=
 =?utf-8?B?b1JqK3FPeGpmMXI1ZUIrWGcvR0RzWUwxL3dmOE1ybzhnZFdlYUh5SXNzK1Fa?=
 =?utf-8?B?WUFsSXZuOVNCbTdhSDVEanlWUkkwbTdGcU5vZVRuZndzQUVDdmU0VWd4bVpp?=
 =?utf-8?B?VEJDR2M4cXhScHZndjhpdTNBZEViWHdiQm1taStKTUtJRVdGOW53TlpDWmpl?=
 =?utf-8?B?UTNQWkZ3LzlOaXVhb0s4aFdvbktRbU9BQlRLNEdycWtWQjdBV0dwTUYrd2dp?=
 =?utf-8?B?YStNSCtLNWtRYlJiQXJYK04vL2pVNDRzNTFZN0lLRUxVV3V6V3Bqd2djQkE5?=
 =?utf-8?B?ZVRuT2Y2RnlJTkFURExMSk12UWJqbTFIWHU1MGd1R2ZKUkhpaTJxYUtONDh2?=
 =?utf-8?B?RTQybjR4YzJlajlIeVMrd2F5L0k1N1NEUkQ3aktjeENUeHFLU2ZHQmFHWnN6?=
 =?utf-8?B?K0piNkRjTEFIRlU0bTNnL0JORkgrRlJxS2FiVDd3VXp6SGpvQ3JSN0NoNk9a?=
 =?utf-8?B?T3lVamp6enBnRUFnWXc2UW9lYWlhR1lBR09vVmxpVDlOYk9xNFpjdSt6RjZI?=
 =?utf-8?B?c3pYQklYSDlKTmtyeHk4dUQyTlJHTWJFV3pzQ1lDdXpma3BydWVHZUFWc3Na?=
 =?utf-8?B?YW1CRGMzUnBWb3dicFpxTDRPM0V1Q2hIUkV3ZDFsZ3NUZkw0R2ZybVMwYXUz?=
 =?utf-8?B?YTZDRGUzZVFDUk5nZENxZCtZc1FpZ2JpRnVtOFM5cDNyVWtuVk9XdkNoUjJX?=
 =?utf-8?B?WTd6bmNucU9pZklqUDgybTQ1aWQycnFnc29uWW1mRHVUbEpXSGgwYjJYakVz?=
 =?utf-8?B?dEx6MmY2em9CU1NFbE9EcGdjMUd0eU5xLzVpS29kSkR6OFJIZXlBWG5OaWVp?=
 =?utf-8?B?YzRJejd0WThGTm5MYUVyRFQwOFlDS1lpRXNkWjg1dEJlWnU0M25HcDhyd3dm?=
 =?utf-8?B?TWR1ZmZ2WTA1WkZKa28rWkFHblB4VWxZVDYvQVd4bEl2dHVqQnozYmhmS1NG?=
 =?utf-8?B?MTE0SlBRTlpKbElJY05seHEzOHlPUmZ5NlgrUC9zWElxZkZaRTZHdkkrNGxZ?=
 =?utf-8?B?SEZMN3BnWjNwM2JZa251cHVEK2hyNktPYWs5Z1RMOGpOKzNBWDRLZis2UnMr?=
 =?utf-8?B?Y3BuN2cramF4UTRTSmlMaTBYYlJvWmRhOEx4VmZTRkU0NEdVd2VCQ0E5UXBB?=
 =?utf-8?B?Z1FUQWdjSmtwb0FRWStFNFRxWXpKSVlrTUxCNmNDc2ZTa1NJWTNKNWxBaks3?=
 =?utf-8?B?bHZvSjF5WDBuVkVPUkk5Nk5CNnZYZmczdC9TdHNzcjNOUUV5TVhqQmtuUEVG?=
 =?utf-8?B?NEhaZlFkSEJwRy9xdytCcXo4VHpMMzVpM0JySFdKZ0dxcW9mWno3NTdYN2Mv?=
 =?utf-8?B?S0h5eVpjazNjRHhYMWx2QnRrdGJMb0dLSGtyMEwwc0VXd1lKTmVhVXRBcDlD?=
 =?utf-8?B?a0ZacUNmc280Y2UvTkZRTXVKUHhjbWE3SlVCQmtFVUZMckp4TlB3dUpaVjh5?=
 =?utf-8?B?WHB2VC8vaGJXa3RiZ29uNTk3d1BHT2NyMHozMjg0Wit0b093RDJ0cjJob0Rl?=
 =?utf-8?B?SlpDQXlYNnJLTFJYR09FalVMT0ZvOEdtczRvSEczZjlXZ1lLWU9OTmRmUGd2?=
 =?utf-8?B?OWR2NXBhUnc2Vmg4ejRpWkZCbEl3TWVrYmhESEpzdmtFMXY5TFY4L0dBNlVZ?=
 =?utf-8?B?dWZYa1RhRUJwV2kzNndjNC91azMrVEJOVG9YSEY3d1Ixc3I4c0VZeUNlMDRh?=
 =?utf-8?B?VWNhNm01dGpHamFEMUl0dWp5eWZtUnVDdVBuMkUrREFobEpteEoxLzVtZEFt?=
 =?utf-8?B?b3cyM3p6UWFTVVRwZS8xTlBwT1pyQmtmUFdwenNIUDQveFAvaFBVUGtHS2Zt?=
 =?utf-8?B?bCtpV0pCVGZmUzA5YnRQblltdUdVL21qeWFDdGtsbWxRelI5SUJRb2FUNjJw?=
 =?utf-8?Q?wc8uhe1vCz+SV/El0z8KANp0nX7t0EKdEajvlD1Yr4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A4231629459B3446B35005D50AD6A6D5@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 0m1BdXhOnePfy+unWKhkgRR3XcFih61Na1TJ+mzxft+V/PIHPm7FIa+oJ+FweSG0fOw3uekOj0Smnay67lxpxpsTDKRE3/EeLuyoKCF451UvBIVu8U52uSECLdegbl25vS9R2S92RvkQab8s+Oo7lMwTfsDjpLvBT7nRaCaCEIsnVwiidco0GWC1fqVm+SXcxl+aFTvEDwwPtHBwGEqAzVAZvqwmybHV4atPIE8xLFPSy13N4nS+Imr4r1z8GXCaC2tBrqrGszhdg445aoCrEvEieQ7dk8bC5mcN1aFb61BXjtl6nxTE+QiF1Gq7sVLyef6R/At4jKzs/+zwdhgZGTo9BTBw2Vok4lm/3NCrORcCmfhCFlyt1JU5oJid+NIPSsjaBaMfIyyCYsFczAyFjpQoy/Ggjfz0S/Sr1lq4VaW/EnefnSeI6eO7n/EJlZuRLD4QAGPzFj1gVbnw8gEWtmmxdRQRPnIR+x0sW4zuePQ7FhU9IxZmpeB1NGA6e2yxkq4SzMmzZwgfcuxf9jZLAZENFJ26UFMj4LYH2s1gQXV7ChcyikI47MM1yE4yTFhiDzlIh1tNdZQhqVd+JFPIojNxc6Ry7MIpkzs46ngW4D0T66Cg0IdX0inHbwIp3ME4v1rgpg7IK6LqMUdZ8ExxEZGRNbR1Oe0M4/UHatn03QMOVDyo7PIwqM79yI3LrgWP40cJWFXxnYqQ7zRixpACsVkskdXe/Agd3bY0lmZSUQGBpQY+RzL1DQtZvV+CWGpb/wKavznZCdjaBBPlSrdf5s8uq7aZLsO8DgyI4VVwNJ2RIBtH0Pkxqrd+n3wfpWxf
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c9dead2-8c2f-4ea1-9999-08db143478c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2023 17:52:59.9684
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r2UtVL9kO7PIbt85FWOWLeSrJnq5KbfAZmScPnOUGy+4MzSpT8XpfsLpNH4R22HLhLCbzwy4gHpzeKcQ9WYxDZpkSJt373s02myvs56ac2Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB5842
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMjEuMDIuMjMgMTg6MDgsIEZvcnphIHdyb3RlOg0KPj4gcGluZz8NCj4gDQo+IHBvbmcuLi4g
OikNCj4gDQo+IEkgaGF2ZSBzbyBmYXIsIHNpbmNlIGFwcGx5aW5nIHRoZSBwYXRjaCwgbm90IHNl
ZW4gPjEwMCUgcmVwb3J0ZWQuDQo+IA0KDQpHb29kIDopDQoNCj4gSXMgdGhlIHByb2JsZW0gdGhh
dCBgbGVuPTUzNjg3MDkxMjBgIGlzIGxhcmdlciB0aGFuIGEgMzJiaXQgdmFsdWU/DQoNCll1cCwg
aXQncyAoMSA8PCAzMikgfCAoMSA8PCAzMCkNCg0KU28gdGhhdCdzIGRlZmluaXRpdmVseSBhIGJ1
ZyBoZXJlLiBJJ2xsIGNyZWF0ZSBhIGZvcm1hbCBwYXRjaCBmb3IgaXQuDQoNCj4gDQo+IGt3b3Jr
ZXIvdTEyOjYtMjY4ODggICBbMDA0XSAuLi4uLiA0MzA5NDguMDY5MzU2OiANCj4gYnRyZnNfcmVj
bGFpbV9ibG9ja19ncm91cDogNzc0NWUyZjctNWM2Ny00YjE4LTg0NGItOGU5MzM5OWY3YjBiOiBi
ZyANCj4gYnl0ZW5yPTM5ODg2NTM1NzIwOTYwIGxlbj01MzY4NzA5MTIwIHVzZWQ9NTE0OTk1NDA0
OCBmbGFncz02NShEQVRBfFJBSUQxMCkNCj4gDQo+IA0KPiANCj4gQW5vdGhlciByZWZsZWN0aW9u
LiBJcyBiZ19yZWNsYWltX3RocmVzaG9sZCBhICdoYXJkJyB2YWx1ZT8gSSBzZWUgbG90cyANCj4g
b2YgbGFyZ2VyIGNodW5rcyAob3ZlciA3NSUpIGJlaW5nIGJhbGFuY2VkOg0KPiANCg0KSXQgc2hv
dWxkIGFjdHVhbGx5IG9ubHkgdG91Y2ggY2h1bmtzIG92ZXIgNzUlIHNvIHRoZSBiZWxvdyBpcyBv
ay4NCg0KVGhlIG9uZSB0aGF0IGlzIH41OCUgdXNlZCBzaG91bGRuJ3QgYmUgaW4gdGhlIGxpc3Qg
YXQgYWxsLCBzbyANCnRoYXQncyBhbm90aGVyIGJ1Zy4NCg0KSSBoYXZlbid0IGxvb2tlZCBhdCB0
aGUgbm9uLXpvbmVkIHZlcnNpb24gb2YgdGhpcyBjbG9zZSBlbm91Z2ggeWV0IHRvDQpiZSBhYmxl
IHRvIHRlbGwgd2hlcmUgdGhlIGJ1ZyB0aGVyZSBsaWVzIG9yIGlmIGl0IGlzIGludGVuZGVkLg0K
DQo+IFs0MzA3NjEuMzQ3ODQ0XSBCVFJGUyBpbmZvIChkZXZpY2Ugc2RpMSk6IHJlY2xhaW1pbmcg
Y2h1bmsgDQo+IDM5NTk2NjI1NDI4NDgwIHdpdGggODUlIHVzZWQgMCUgdW51c2FibGUNCj4gWzQz
MDc2MS4zNDc5MDRdIEJUUkZTIGluZm8gKGRldmljZSBzZGkxKTogcmVsb2NhdGluZyBibG9jayBn
cm91cCANCj4gMzk1OTY2MjU0Mjg0ODAgZmxhZ3MgZGF0YXxyYWlkMTANCj4gWzQzMDc3OC44NDc5
NDZdIEJUUkZTIGluZm8gKGRldmljZSBzZGkxKTogZm91bmQgMjEzOSBleHRlbnRzLCBzdGFnZTog
DQo+IG1vdmUgZGF0YSBleHRlbnRzDQo+IFs0MzA4OTQuOTkyNjI4XSBCVFJGUyBpbmZvIChkZXZp
Y2Ugc2RpMSk6IGZvdW5kIDIxMzkgZXh0ZW50cywgc3RhZ2U6IA0KPiB1cGRhdGUgZGF0YSBwb2lu
dGVycw0KPiBbNDMwOTQ3Ljk4OTA2OF0gQlRSRlMgaW5mbyAoZGV2aWNlIHNkaTEpOiByZWNsYWlt
aW5nIGNodW5rIA0KPiAzOTg4NjUzNTcyMDk2MCB3aXRoIDk1JSB1c2VkIDAlIHVudXNhYmxlDQo+
IFs0MzA5NDcuOTg5MDgyXSBCVFJGUyBpbmZvIChkZXZpY2Ugc2RpMSk6IHJlbG9jYXRpbmcgYmxv
Y2sgZ3JvdXAgDQo+IDM5ODg2NTM1NzIwOTYwIGZsYWdzIGRhdGF8cmFpZDEwDQo+IFs0MzA5Njku
NTk2ODc2XSBCVFJGUyBpbmZvIChkZXZpY2Ugc2RpMSk6IGZvdW5kIDkyOTUgZXh0ZW50cywgc3Rh
Z2U6IA0KPiBtb3ZlIGRhdGEgZXh0ZW50cw0KPiBbNDMxMjUyLjE3MzIzMF0gQlRSRlMgaW5mbyAo
ZGV2aWNlIHNkaTEpOiBmb3VuZCA5Mjk1IGV4dGVudHMsIHN0YWdlOiANCj4gdXBkYXRlIGRhdGEg
cG9pbnRlcnMNCj4gWzQzMTMwMy4yMTA3NzZdIEJUUkZTIGluZm8gKGRldmljZSBzZGkxKTogcmVj
bGFpbWluZyBjaHVuayANCj4gMzk5MDgwMTA1NTc0NDAgd2l0aCA5OCUgdXNlZCAwJSB1bnVzYWJs
ZQ0KPiBbNDMxMzAzLjIxMDgzNl0gQlRSRlMgaW5mbyAoZGV2aWNlIHNkaTEpOiByZWxvY2F0aW5n
IGJsb2NrIGdyb3VwIA0KPiAzOTkwODAxMDU1NzQ0MCBmbGFncyBkYXRhfHJhaWQxMA0KPiBbNDMx
MzI0LjM3OTYyN10gQlRSRlMgaW5mbyAoZGV2aWNlIHNkaTEpOiBmb3VuZCA4Njg3IGV4dGVudHMs
IHN0YWdlOiANCj4gbW92ZSBkYXRhIGV4dGVudHMNCj4gWzQzMTU2Ny40NjA2MjBdIEJUUkZTIGlu
Zm8gKGRldmljZSBzZGkxKTogZm91bmQgODY4NyBleHRlbnRzLCBzdGFnZTogDQo+IHVwZGF0ZSBk
YXRhIHBvaW50ZXJzDQo+IA0KPiBbNDM1OTg5LjI4NDU0Ml0gQlRSRlMgaW5mbyAoZGV2aWNlIHNk
aTEpOiByZWNsYWltaW5nIGNodW5rIA0KPiA1MTgwMDg0MjEwODkyOCB3aXRoIDkyJSB1c2VkIDAl
IHVudXNhYmxlDQo+IFs0MzU5ODkuMjg0NTU4XSBCVFJGUyBpbmZvIChkZXZpY2Ugc2RpMSk6IHJl
bG9jYXRpbmcgYmxvY2sgZ3JvdXAgDQo+IDUxODAwODQyMTA4OTI4IGZsYWdzIG1ldGFkYXRhfHJh
aWQxYzMNCj4gWzQzNjEzNS44NzE5NjddIEJUUkZTIGluZm8gKGRldmljZSBzZGkxKTogZm91bmQg
NTcwMTUgZXh0ZW50cywgc3RhZ2U6IA0KPiBtb3ZlIGRhdGEgZXh0ZW50cw0KPiANCj4gWzQ0NDc5
OS45NjgyNTddIEJUUkZTIGluZm8gKGRldmljZSBzZGkxKTogcmVjbGFpbWluZyBjaHVuayANCj4g
NTE4MDcyODQ1NTk4NzIgd2l0aCA5NiUgdXNlZCAwJSB1bnVzYWJsZQ0KPiBbNDQ0Nzk5Ljk2ODI3
MV0gQlRSRlMgaW5mbyAoZGV2aWNlIHNkaTEpOiByZWxvY2F0aW5nIGJsb2NrIGdyb3VwIA0KPiA1
MTgwNzI4NDU1OTg3MiBmbGFncyBtZXRhZGF0YXxyYWlkMWMzDQo+IFs0NDQ5NDEuMDA5MzUzXSBC
VFJGUyBpbmZvIChkZXZpY2Ugc2RpMSk6IGZvdW5kIDU3ODc5IGV4dGVudHMsIHN0YWdlOiANCj4g
bW92ZSBkYXRhIGV4dGVudHMNCj4gDQoNCg==
