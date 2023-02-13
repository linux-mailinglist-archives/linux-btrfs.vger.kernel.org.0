Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1276694374
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Feb 2023 11:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjBMKuL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Feb 2023 05:50:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjBMKuG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Feb 2023 05:50:06 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544BD6A76
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Feb 2023 02:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676285400; x=1707821400;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=8QEHAMJcqk/FUJ1b6inIi2s/6E1/wjNpbMZ4FsKkrnc=;
  b=aczb/PUUls1lDvpyzZQh8JfkjDCM7dIxoaDDWfVrVcYYAgpVLrvTQIlS
   lugX6eA5t2O6jtpX16QewiedrVNswVFoNa2I1oR31MZ7RRa/odw2gXFt/
   d/TT5hzJ9SKKsDYX/Lo7qfM9o0MA+YyJLVsXKpp0IICh/LPF5ArObpiHH
   H0u6uHdqMNccA2yEfks4PK5rOVZnTGkgyMElMNPaB0359sPeZGsaVSnMU
   7GQyQrsOE467mdEbLTkt94a31t4Va2hdCfY80q7sgMlb0G4w7PeNg8axT
   BZnt5gSyQHyGeId8Yr7WHq35qOOTfNtmV3+ODmDWHcLiJNkS89Hy6elJ5
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,293,1669046400"; 
   d="scan'208";a="223197448"
Received: from mail-dm6nam04lp2045.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.45])
  by ob1.hgst.iphmx.com with ESMTP; 13 Feb 2023 18:49:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W5wNAwijbmW0kpeFteGdS53ZaeAFrotqoerQNdPY9qAERe4c5+8Jqpjc3UNocjs3Y9aDCUqflMlwdfbh/hQBI1KURn2l0L1BirV+6nyDHimdykuqMN8aW59DXwlD33U06LKq91PhawUxGC9hKWIE0/i1r8TDR8VjTDxC7zPUnuOY7gOz+xMe2ALI2MRoPGuZ3dq76mjugkF+fhvZ7AqW8KZJcxqOIoI7DwVJeC1vGh0VryiZDjX1aTpFTYOczdQNNYEJVGzGaziSfjn/1RSKmbmb+8LuG0QnBh0dlBDb4LDoyTHmY1/wU3KEhE3GhYpdLMm8r9pdFSdkN6UX1Sf8Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8QEHAMJcqk/FUJ1b6inIi2s/6E1/wjNpbMZ4FsKkrnc=;
 b=ZfLUFqk0ox7M791LpJg9rxVVyK7EaO4ypryIlREDZfEndciOpOEI6fbXX1Iakqqc89g14olDE/msbUNG7pu+d5R39Lr4DG/4ZfQqS/4CS5LNWAs9lhab4rcO2wmvwjR9lOtTJFFpfNmOgQus1jMOVXQzz9ixBTs7Hqw2XoMFyU/Tpr8l6TN4e0eWmJ18RMWdCWmmDXvDG/p4EPXfgSKvFlFv5uxJ5S/V2YgVSulB3aYMK9z8jGFYZL9OHpuv0MXLimuhRozT7nfgi7KK0muv5Zngl94j3WF65ntpEgHhQnt3LQvcwkpIN70mMXRRJGflp0YOLRpd7GbRBkEOW7zH/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8QEHAMJcqk/FUJ1b6inIi2s/6E1/wjNpbMZ4FsKkrnc=;
 b=Gb6FZe6mvU3sw4RH6adrccIEvcaRdNt2RKi8pkO7JWe/3uvPmqj668hN82OAouXbST1BiMV6LyKW3mKXNt5y7X4SS5Uvpzc9XjycUL5wgXS6zxA7vNXIsuadEX3GZb6fQmt5oemsapiKNxNkZ52WJjZpZv7pZ4ZR6lIsi8p+Cew=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7753.namprd04.prod.outlook.com (2603:10b6:510:e9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Mon, 13 Feb
 2023 10:49:57 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%6]) with mapi id 15.20.6086.024; Mon, 13 Feb 2023
 10:49:57 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v5 04/13] btrfs: add support for inserting raid stripe
 extents
Thread-Topic: [PATCH v5 04/13] btrfs: add support for inserting raid stripe
 extents
Thread-Index: AQHZO6w3+DMLZggJn0KZylohlYh4hq7MhYOAgAA09gA=
Date:   Mon, 13 Feb 2023 10:49:57 +0000
Message-ID: <30f068ad-d704-9316-992d-290630256712@wdc.com>
References: <cover.1675853489.git.johannes.thumshirn@wdc.com>
 <96f86c817184925f3d1e625d735058373d90e757.1675853489.git.johannes.thumshirn@wdc.com>
 <54c0f200-2598-37e0-efe8-1cb6d65c9774@gmx.com>
In-Reply-To: <54c0f200-2598-37e0-efe8-1cb6d65c9774@gmx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH0PR04MB7753:EE_
x-ms-office365-filtering-correlation-id: 076878c9-d456-4951-5e5b-08db0db00c38
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w5xbTNgnV/BGzUoNzU1qEC5qAWKEBft2QeBjBfX0mDw87wCj4hwPDRE2d60HzlP1VamcsdcnflJuk1F3LrVyZox/aTdx4DtgVaOO+KUo/I8uNJ9m8Clmcj5wXf0DFhsHAjGhLoaHbrNqkIp5V3aoFnCU5IjHxsjKGG5nITbBqNZVAWz/b01kJpfMisYlOBWN3hncS1h2l7bPADlJMzs2O39M6tVKQt2oUTYzzSbkA4XPrU//aqUrmgu9f1fEqZuNct0AVqXTJ0ao3V0l/0DS6Y5f7Ao08N7/ZrdK58HOIY2/aS8IN3J9EQsxnvIKHU2KjNZVuS747Z9uDdzRV4mZBFOHw2OSc/0bGLPhtnCSwWQg9JDMSAqHqH54zt2Aq8PkhR8XWoFIs16dVUBOu2i2TldB7izbhbCTXy53d5NnCnKxWDvwlPSiuQdoZjMnL5NJMnDOONsdfVaIUr5ihQeLD6OIykaRrNrOJ+sBUilTM4NuD2cjfipeE3HTan9o266il+Vs27ycoRpBt+Rx8iPaSTMySR/3sdrWN0YtrwyKckhDvlrpdNQHZz3WHrlxRcB6pxuOy0t34rdNiaqTXaQQ9XywDHmn1gEACUKGEeFBGjCCzJ2tEsZn0GHeLHo5Uty47k0UNEa0aRR9RXEih7Mh7ldJCHs7yYOUyVw6n0XoHigYsLAY3zOG3nz3F7FkguGBq0GvBeOk/L41gJqIuYoOK2LiId+tVywJqsB0CkvIP4haU5C9dABPDu9+aVNfQJuBGYM4Igka/Q++PAUA49p/0Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(366004)(376002)(136003)(346002)(39860400002)(451199018)(31696002)(36756003)(86362001)(38070700005)(64756008)(8676002)(66476007)(66946007)(66556008)(66446008)(76116006)(91956017)(83380400001)(110136005)(316002)(53546011)(71200400001)(6506007)(2616005)(186003)(6512007)(6486002)(31686004)(478600001)(82960400001)(38100700002)(122000001)(2906002)(4744005)(8936002)(41300700001)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aHBQc3ZLQUhRYzJodjNuaDNlMzY0RWkvRHhCcmF1Um1keDRENWx6d0NnYVFG?=
 =?utf-8?B?S0RyalBLV0ZjUVRUeWtQUzg3dHlqRHlNKyszd2xRS2U2anpIWk9RdklxeTk3?=
 =?utf-8?B?REtZdit0bHpqelJPc0VMWEY4VWZRTTVWSXI2am1kMFNHakJIbTFaNTdtN25v?=
 =?utf-8?B?dnpWbVZsTVJydDdKOFd5YjkwOXRIYUI2YThEWlNad3lqQ0krZERpUm5CRlNR?=
 =?utf-8?B?dUI5K1BwSW9MVmxrSTRzUGJlNlRRNzhraDdsa0tTWUxkOUtIV2ZrK3dxU2pF?=
 =?utf-8?B?RTZqR2hpZ3Q1eEowMW5zS01FKzdGcDhMRVlGVGhoNnAzaVE3aTlOM24vZlBH?=
 =?utf-8?B?UTlQR1ZQUU5rNkxkbDV2enhLRWZ2eFU1dkh3Ym5HTXFnMU0ydnM0d2FGZGxp?=
 =?utf-8?B?TDVESzNaWlVPZm9PWDlzZVhlRCtiM0ZnYlBtVkRuVzkvdFp2N2g1NTZNMHFK?=
 =?utf-8?B?WmRiME1nRC9TSjAvNUgwcHZ6RU9ZWEg0dXFBdGNzbXpGU2JFRHVxTEF4OUxU?=
 =?utf-8?B?eEZCaVV0NkcyUnM2b2tpcWZUS3pQT1FuQ0dkblpDM1JWVHhEdDZYY0wzeHJ5?=
 =?utf-8?B?WVM5SU5Ya0s2dmN3WU02ZmtFa2dMcWM0R01Pb2tmMEFZOVFpRFQ2L1YvQWph?=
 =?utf-8?B?Y05BQUVkNXcyRkM5OTBCdytjZVhoZDVaUkh3eDZTa0J0alUyd09JMDJERXBL?=
 =?utf-8?B?K1ZWQzlaM1JxOUtXcUdXdnRpZWxiSGlsNjJkNzExajFwd002RURYZVB2Q0J2?=
 =?utf-8?B?M0pHYXFteUdrQXYzU3JIMmpGVGkvOGxnTGNkN2NmTjRFRUc2dWVoSzYranRX?=
 =?utf-8?B?REd1dWZQY1p3TzA1WUoweUFCOTRVY0w5VEhJaWNKNDdTVHBMcm54NytMSFlu?=
 =?utf-8?B?RFk5OFkyaWIrMW9ZT1MyTEwwZ1BYMHM0M3FvTmM0NUkyRllla1gwVGk3b3E4?=
 =?utf-8?B?QzYycGErY3JOYTc5djB0SGQ3YVJ5Y0tjYlNmN1BPS0RyVTdGOWZKZGNzYnBh?=
 =?utf-8?B?WHROcDJRUjRob3hpVU5qTm1CSjBDUU54ZnJ6NGpsQlRQYlZDVkE2NjRFVm4v?=
 =?utf-8?B?bk93b2tyUkYxY0xvclNPSDJWRi9qcVVmTG9vbnFvN2FwZXZSUTJyUW9kUkxr?=
 =?utf-8?B?Wnl4Vlp5QWR4b2FiRHEyQUpsYldKNmYyWHNyT0hudUtuVzdJbkdGcThySlhy?=
 =?utf-8?B?b1J6cjRQZHByR3NldVpKbm5sVEwxVzRWSkNLMHMxa2s1Znh4bmxkNTVYOGNx?=
 =?utf-8?B?ckJObEN2WUF5SGVVLzdOU3FVN2Q3b01WS2VITHUzR2FYa3dtWjlXbHI3bXU5?=
 =?utf-8?B?ZTErMzRIbVBOZjZNNzR4dVdRa2xrcGY0SHJyMWxGQXdVS0lvLzBSOUJ0cjcz?=
 =?utf-8?B?Ti9kZWRYb3JWZERtNjhDSmswUWtKc2dSYlFjUytQQytrbUlrMDM4Zldtbm1M?=
 =?utf-8?B?T0ZBdWZyT3lSTlUrNTliaXh1dFQ2UStkdzRBK3IvUGI5SW55WEdNSk5sQS80?=
 =?utf-8?B?S3RCWndYK3l2MkpXRUJZUFpHbEpsNEJlaU5FKzFYYWN3MTRnZGhjQWJXK2Nh?=
 =?utf-8?B?TkEwN3Vndk5rZVlwTXMyTW1UZ2wvdXc4TjZKTG5aYmQ0MjBkcGhJS0M2aTQv?=
 =?utf-8?B?WDk2UEJyOVJUYVVVOWdNZitBMlplODRtTm0zYVRwT0FFNEF3ZjhUT29Zekg2?=
 =?utf-8?B?L0FvQlNyOXJydUlOSnNCdHNIUjlKa2c2ZnZhUmlTOGdhSG5zSEdTZ0czQm1X?=
 =?utf-8?B?NW1BK1NEMFRRcVJuRnZFRGk5c0x5a1BXU0graEtCcnJSNTNGdjdLMVhDN2Rj?=
 =?utf-8?B?OFF0QWhGZWVadjdxSWVMQnhPSG1IZ1l0OE41d2JIUjV5emJVWURYYXBFRXBw?=
 =?utf-8?B?d1UrVnE5VzhvNkdMWk4wejlrMmRtR0RKQmpqKzNBQi8vbGFoY01nK0lhb2Uw?=
 =?utf-8?B?SFZ3eXVvbzJOektYaEJBc1p1cmZVWWdjTDZ3MFFXRmhsR2tyeFF0S1RBczF5?=
 =?utf-8?B?NWtGOFZUUUptNDhkZ1l4YVI1QmJmdGs5MHJRbEsvWDhzL2VsTEYvUjNld1ht?=
 =?utf-8?B?VHhtSHEvcXJaNXV5M1F6Wmx2WThZTzdEVUhJSlhzT2xVbUhiVDJxV3JaMFBU?=
 =?utf-8?B?L3lsazVyRE1maEMvVmNSN3crNHprRVRQeDVXUHk2bjZUMk5ITUE5WmdKTG13?=
 =?utf-8?B?VUZJdCt0V0pUS0Fia2xvK2szeXFOYTVHQ1FTMEJyQ1pja2p2Sm8yWkhxRFZk?=
 =?utf-8?Q?NOutb+mM9e7MS8A3dZNsXfd7Ze57e2FESQW8OPBr74=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0C6946E486434948B34A0AD6BE08EFA6@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Hyuy0NRHBdwL7vXywvZ5hHBHGW1L5CPaKXCJZiXWtsNAYEmIDr9wjEhnrrPd1nzNDvYwKpjxWPXS8MJV+WI3C050ioh6Gr9BbCE/w+GxXsS67YBf+mDl2DgJaoQw73DEFpa8Ur4JH0NGiwFCnP/GmRDB4COTzcmlF7VMoulRJ8wb1RzkWSAwo4m6r85lJJhrPKst2ggYGH3k4pcXRt11vLYkyOGpWZK2kq3yynUcyHG7DLLTTuC+Z7wwBa8M5gi3NzNgagJdMVZTyzKHqo8Qc++9Xd5X5N3VaNpCa6iM2Jpzw60zdf/8zn9h0STGBIxFnVT83gHpuPCn1zyleqbwG++VmAAEFQnwgtocy91Ahl2ODhcKsIHa560gxclYrkL+bYCsUO59/Ws/sjrQXxoVlcckLIka/PAenakWhyAZR0LBChc5oKlmG/SaAGH/EgfiyOAcYmEqWGDrjruOc6XOemc/pFJWubN84CnD0wl9jReiieQTTTwFPHNUfzA96ILIE9fC+COLVtVjc75w0mc4l/OPoTWpQnpneUliGSDDRxUd/wvNLVIUUkkL3jMQM/5s7gCYvwWzlfCTHBEsS2UtnOhEIpSMwUS83j5MGppZQl7t/8raMa+5PsxM60L16Vb5GfjDEpvNHycYYJNW6F1lGs5YhfOfnaqQZeTrDiEh0RI4BbA6VPtB4/eaI3cZxFerPNM4rw3blDSUC/sEnxzpX9ODfcK+BjKvPjEmCf/0JdfZAldP755adwWvSzQ/7X/om331HhTkxRdCcy53Ur1BZislzmHb0RtEtLPi1l76gly1UhAPmpdivxoqHUNu+eDW
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 076878c9-d456-4951-5e5b-08db0db00c38
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2023 10:49:57.3014
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XFE1RjryVmyNlumN37sgCzr6tpsuh04XmuzCfc6qNJ0DcOfAMRY0dIpPJ/XJBpfw2wAdQdnPWj/vSgSYyAPLzQBWd1t6Rcpm6E+vUCWfvao=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7753
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMTMuMDIuMjMgMDg6NDAsIFF1IFdlbnJ1byB3cm90ZToNCj4gU28gdGhlIGluLW1lbW9yeSBz
dHJpcGUgdHJlZSBlbnRyeSBpbnNlcnNpb24gaXMgZGVsYXRlZC4NCj4gDQo+IENvdWxkIHRoZSBm
b2xsb3dpbmcgcmFjZSBoYXBwZW4/DQo+IA0KPiAgICAgICAgICAgICAgIFQxICAgICAgICAgICAg
ICAgICAgfCAgICAgICAgICAgICAgVDINCj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gd3JpdGVfcGFnZXMoKSAg
ICAgICAgICAgICAgICAgICAgfA0KPiBidHJmc19vcmlnX3dyaXRlX2VuZF9pbygpICAgICAgICB8
DQo+IHwtIElOSVRfV09SSygpOyAgICAgICAgICAgICAgICAgIHwNCj4gYC0gcXVldWVfd29yaygp
OyAgICAgICAgICAgICAgICAgfA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
fCBidHJmc19pbnZhbGlkYXRlX2ZvbGlvKCkNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHwgYC0gdGhlIHBhZ2VzIGFyZSBubyBsb25nZXIgY2FjaGVkDQo+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB8DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB8IGJ0cmZzX2RvX3JlYWRwYWdlKCkNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHwgfC0gZG8gd2hhdGV2ZXIgdGhlIHJzdCBsb29rdXANCj4gd29ya3F1ZXVlICAgICAg
ICAgICAgICAgICAgICAgICAgfA0KPiBgLSBidHJmc19yYWlkX3N0cmlwZV91cGRhdGUoKSAgICB8
DQo+ICAgICBgLSBidHJmc19hZGRfb3JkZXJlZF9zdHJpcGUoKSB8DQo+IA0KPiBJbiBhYm92ZSBj
YXNlLCBUMiByZWFkIHdpbGwgZmFpbCBhcyBpdCBjYW4gbm90IGdyYWIgdGhlIFJTVCBtYXBwaW5n
Lg0KPiANCj4gSSByZWFsbHkgYmVsaWV2ZSB0aGUgaW4tbWVtb3J5IHJzdCB1cGRhdGUgc2hvdWxk
IG5vdCBiZSBkZWxheWVkIGludG8gYSANCj4gd29ya3F1ZXVlLCBidXQgZG9uZSBpbnNpZGUgdGhl
IHdyaXRlIGVuZGlvIGZ1bmN0aW9uLg0KDQpJIGhhdmVuJ3QgeWV0IHRob3VnaHQgYWJvdXQgdGhh
dCByYWNlLCBidXQgZG9pbmcgbWVtb3J5IGFsbG9jYXRpb25zIGZyb20NCmluc2lkZSBhbiBlbmRp
byBmdW5jdGlvbiBkb2Vzbid0IHNvdW5kIGFwcGVhbGluZyB0byBtZS4NCg0KQW4gb2J2aW91cyBz
b2x1dGlvbiB0byB0aGlzIHdvdWxkIG9mIGNhdXNlIGJlIHRvIGJ1bXAgdGhlIHJlZmNvdW50IG9u
IHRoZSANCmJ0cmZzX2lvX2NvbnRleHQgKHdoaWNoIEkgaGF2ZSBmb3Jnb3R0ZW4gaGVyZSB0aGFu
a3MgZm9yIGNhdGNoaW5nIGl0KS4NCg==
