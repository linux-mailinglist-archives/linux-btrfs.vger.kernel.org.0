Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27990602C84
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Oct 2022 15:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbiJRNKV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Oct 2022 09:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbiJRNKR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Oct 2022 09:10:17 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002779D506
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Oct 2022 06:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666098614; x=1697634614;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=V238jqLj8PhVWtBQAoS7sLgV5QPWRQxxkaeUOtTRjiWAIQzFrAGLZy3D
   AOoU6cBkDysZgyI1ishTPMDOSQnRG7k1/yWtNPqLc+PW9T0rDryFwCoS8
   sui8DHR3pMgLWbFztjJQsJdMDflx3XPz9vejFX2Ck4E54iggH2zPbFc0S
   NOHQHRS9urqJT677gOV/q62/mG3Kca40oC7eOwpTO00bHN0JFAbNaM8O/
   g9+8GTYyOo89QsG6QHGM2yx5rVg/wYmeBk3YhD/GbRhBgB9SgvfaeGk7H
   Mc7XGqt9NHtgzaDJSl/O//GsWjeDImk+lt0RdsJt9GI4mLiSmDZ4xlQsR
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,193,1661788800"; 
   d="scan'208";a="318443749"
Received: from mail-dm6nam12lp2177.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.177])
  by ob1.hgst.iphmx.com with ESMTP; 18 Oct 2022 21:10:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DySm/CzKbMafMXsIffya7o1agDWtghTWsZvCRMSR98kZV4MrUuYdy7Ie+pYDlJwMRxggh1XxqG6ull+3bPldPbj2vsbRGXzYj/cwVEga35955GtF/Y1f/SHkWpIi8mJxB/SGPxcdOelx2v1lP73WcKgI6p+z9D4XsXCOrncRpfHwC+OAI0UXYOPtbw838pNw+99SAkGBMtO6tkpE9255I6MXRvofo57YDl3dl5xQ+fipz90gAfDq5vjgFMT8za9zSVNuwO7je4bVbhejTbzjqsdJFSwWAqGhlZjtPEkmczei7wW30fwqO+MBWbB1JgyICISN6kVrQ07ECDW4s8ceKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=oaQjrP+dTwc1GnCf5Iuu8KwOFWj3IAiIv+ZWApDr+fj9C1SjoReGwTARdvzQw+Bia7fZ4gypnOi8HtAXchY23k1unYHjvaA2Em+yo3372Qv1NXTT+3fTSZ6M1Lkbf3wnVJ0NsRueGuyvzajEqLW7naSmHVT2ix8NLNETc+gYsjebfXp13B+ezPVSPkSEo6IqhVVSmt0s9nkRKXKCI3GpYcpNoUboNlX/Mvnt+H/D3XdG3jubTv+K5tJeA4MLoFH8Ro1GgpJChuemx+f+fqywA9lBLDPAkLWFRSdYGzhDYscmmd3vwHGk1qtLA/K1hhbnhL7bDuGSfspynRoeM4dzTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=v7eczchZJ4iZbAm8fFpSxVdC+9i1YP2ysf8uI1YpH67dZ6+fH2kopETPusVQEO5Tfa1F6B8a+ZUdgA62e0/3SAbwuBJrJG5AoUOIwcA/CCLAFjC+5YlF+KDgr46vNpzhNx2JcWBXPY09eeD/D6I6O0/2/UeuXpzQvv/1rU7+afg=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN8PR04MB5635.namprd04.prod.outlook.com (2603:10b6:408:73::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Tue, 18 Oct
 2022 13:09:58 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::34a2:dabd:a115:edff]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::34a2:dabd:a115:edff%5]) with mapi id 15.20.5723.034; Tue, 18 Oct 2022
 13:09:58 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH v2 11/16] btrfs: remove fs_info::pending_changes and
 related code
Thread-Topic: [PATCH v2 11/16] btrfs: remove fs_info::pending_changes and
 related code
Thread-Index: AQHY4lwLWGDGyLC3GE2+JUY9mCIl5K4UISAA
Date:   Tue, 18 Oct 2022 13:09:58 +0000
Message-ID: <aa8c5672-a68f-df89-e34c-5791088d1c9e@wdc.com>
References: <cover.1666033501.git.josef@toxicpanda.com>
 <41eb60b3f7bce92765f71dd1e1658bc3ee9babcc.1666033501.git.josef@toxicpanda.com>
In-Reply-To: <41eb60b3f7bce92765f71dd1e1658bc3ee9babcc.1666033501.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.3
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BN8PR04MB5635:EE_
x-ms-office365-filtering-correlation-id: a2c2b9d3-1053-4da9-f65f-08dab10a0f0a
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Bvm5ffvHyp3/fSxbxHRD0qDpYzucaar9cu7T6sqzji34h2N+1t+P4lDp+XV7p5GljDMLJidg+AMALoUh5tvP+bvCkPGmpUXdLdXnMZK1e8ppTzkooYwguVKiszRsjk05iTUqJ2UY+6tXc8ExKfmvlDq79qBTcZxDayBUyc2pbJmNz50U+Vhwpr6ThjP3BYDXjj6zwGooVq+7aQuc87tTWz9kNgdwqzmGaXAaM3XEuLJmMe2hTxr2NGOapw/mnZscIbwj+aMtWkTAakhtQCfbU+FfHuDnsUmUKC2Jqb4pVKvOGV541tT4R2AMZjUkOru0DfylkSBDuHMazP8LDhC38pi1NyWslzfS2J7EGGWi2imEZH6wr9AUne0L0Ym+Hk3OrKQV/c9ALVaewLSUPelbk32YdGaUdul09Wnees3Bx6QPNDeu0pdNHQs89Cd0dNyn8Ilc/GCqS6qYimuY8I6baUbVAjg7t+yU714TMGTxVkkS33Z4rKwDUqk3TbC0wIAmcu1Cx8hwdmXV7B2wkcsnVrKbt3LJYQyL8Hg9jybhIyXaaiD/D17Y5OCoTfsiUjDd2eH3pL6Za5dE6ZBUYLB40jskRKNLV2oy/3YidtUTEel6OiVi2XT1jKoYM49fS2gReUZWE1gjZlappQg2SaNwwoetLZvg5E3GX+hRQ/oGQOcOExqmkUY5dOO+8zY8uf6ESF5LupHIzp6sAggZiUdIiFwXMxOavMyf66QsKKOpRD0I8ACO2P0UYNn647RCsfexhnpuM4/CEMSPZCykEo1/MSnzZbiQqNibHGcA/lpryR+BWDv602oJZskOYmwwhn9pgaczmePxaxlIDcLup4uzfw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(136003)(39860400002)(396003)(376002)(451199015)(8936002)(26005)(38070700005)(8676002)(6512007)(2906002)(6506007)(38100700002)(5660300002)(4270600006)(2616005)(19618925003)(36756003)(122000001)(71200400001)(316002)(6486002)(478600001)(76116006)(41300700001)(64756008)(66476007)(86362001)(110136005)(31686004)(186003)(31696002)(82960400001)(558084003)(91956017)(66946007)(66556008)(66446008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R2dDMW8wei95ZUpSNVI3YkV4cmJhdHh4TnZHd0R1empyTWV3SnNYV2F4ampj?=
 =?utf-8?B?amVmeTc0MDdjYkFHZmdIRXdNLytOTzBBd3cxOTg1bnA4d3JzK0ptYW5JdjU5?=
 =?utf-8?B?Ty9TWitaK3RRb1NEaHpkNDMvVjEzazBqaklwSjBmbExISnRTK1Z6Znd6SGNQ?=
 =?utf-8?B?OUhBUkdRYWcrRW5kOXBpbkIzUGJOWWF1WU9ua0NyUS90MlNuSXRqRittdlVJ?=
 =?utf-8?B?VFdSOE9ZTFA5L2cybDNsVEJFNXNmRWNyMUVEMGwwK05VbVdsQUlMenVMMHdM?=
 =?utf-8?B?NVF1S3BBbHljV2lwNmkxTWlDTTErT1o4d1pBV3I4cHA3YWh5dFIxRmhBY3c5?=
 =?utf-8?B?MmpTeFFmVmQ5a0N5QytGZTdPbVZmN2FrZTNMNUZTbC9aZ2tvN1RTK1ltd1FG?=
 =?utf-8?B?VTJpQ0xzdEU2M28vMVZFay9kWEFueitkMmhqY0E5K3BJZGFiNUovSVI4M3M0?=
 =?utf-8?B?eGc1Yy9oTHU0MDhMYWVVTjVYeURvdU9QbEhIOTlrQVY1SUdHQmlTTys1WEcy?=
 =?utf-8?B?a013M1hrRmV4eGRqR2ZoM3FaRXVhZExQZ3A5YmZiQTNnMEUva29UR1FEVmN5?=
 =?utf-8?B?cllKbnJlV2dTQ2tlMEZPR0cvMW1Gd0ZHSTdpdEpST0kyT3V2MkpwK2s4SkxF?=
 =?utf-8?B?bFA5aUlnT3paWDlteHJtbWdqaUJiM3U0aTF6Z1dlajBjdnFJeEg0c0VJQVUy?=
 =?utf-8?B?VTZRUHAxbG5PbkQxR3MxeTVpTzdVVHZyK3BoY2tpRWVFQllCUUxIMmpiOXNQ?=
 =?utf-8?B?TmloZ2RtTDVWT3RJWW54YTNQTUJMeUx6SkFoV1ZDck0vVHN5QWxYMCtkSlRX?=
 =?utf-8?B?cFVoS0xzcDlySmZxdnZMVFVWaWUvSExHUXRkU2ZCNjVnSG1mWmZBT2UyY3Zv?=
 =?utf-8?B?b1pnM2FQM3N5N3Z1bStQMVBIQW5oTVpwbGRSQlVZbEVjaEg4QUMxdk82Qjhr?=
 =?utf-8?B?RHVUSE1oZVJOZWgzV2l2SXN1Z2Z3M1A5QmYrYlZUQlNoQ2szNmx1R0dwOG9k?=
 =?utf-8?B?eEczUlRhU1lLcnQ1OFdpQm5ORURidHFsby80T0lORU4rVzZKa2tpZFpSWVFT?=
 =?utf-8?B?WEdYdnJ0aUs1MDJaQ0piOEFtRmxUanlOT1RyOVNseHA2TkorSkJRdi9jUk1p?=
 =?utf-8?B?ZDROVzRtZFFNT2xVVE5xdTJsUkFDb3hmdjJoazUyWm44OGp2SkpmVG9KTTc2?=
 =?utf-8?B?SWNVeG40N2xYWCtrR21la1dYSDg2aXZPMGMzVnVhUlJ4T3FEcERzUUFjOW9P?=
 =?utf-8?B?QmljUEdjQ1BDbFdiWEYrNUhObHVvMVJSRWMyeTQ3bG5rVFgvc2hyc2hIeWhr?=
 =?utf-8?B?c2ZXSzVVWWIrcW9HNWVRa2ZnMUsrN1oxdXhaRXgzZStzSER4aDZGM2wybFVJ?=
 =?utf-8?B?VFNROE53aGxXRlZQdk9GY0tzSFAvZ0ZESjZ1R3k1dTloS0I2YWJNQlpxelBJ?=
 =?utf-8?B?a0g0Mk1tR0U2QlJIN21hUFNRTk9WMmZLSUcwM2Vzb05xYzMrR2ZQN0lWY3RY?=
 =?utf-8?B?am53S0p1SDMxWWhHeU1SVmNQbVVMYjRGUVMrQ0tMR3NIUXEzalpoOE12OU1S?=
 =?utf-8?B?Tk9paXFEOG10OFpTa0lqQ1RubGNiT0t1bHRkdVZQNWExR1JUc2Q0V2FBdzR2?=
 =?utf-8?B?L1REU3R0a2RTbkVqQjNBWUtyWmJsSGcyY253YzJONE9DV1BRTm5LdlhwWFdj?=
 =?utf-8?B?aWV6dlF0SnVUM0taMWF5ejQxRDJUUkpmT05wMDhGbnJadTdBMFNDV0x5em4y?=
 =?utf-8?B?ZDIzM0NkWlhFZURFSy8wU0Y0d29iVVRQU0xtWkJKZEttbmR0WmpyQ0dJOE9B?=
 =?utf-8?B?N1hZQjg2SWw3RWlua1MwcVVTaExSVHhkNGpBeEFHb1B3S1RZcnRISHc4eVpu?=
 =?utf-8?B?RlJHbUF1OTU5dDZ2aWJkRlcxbHdHNXI2R2VETEJyVHF5NkI3c3l4dTJ4ckZM?=
 =?utf-8?B?SDBhNFBGcjdGYmRjMGZ0TUxseC84aG5xaHo3eFAwN1pibXpkdXE3UXFneFc3?=
 =?utf-8?B?NXBmM1pIQmNZejFlc2ZUUFM0QzFGNHY0Zlh2MGswWFZWR05nMDZBUmNBbEVM?=
 =?utf-8?B?RmlBbTV3MDRiaFBMSXRlcld1UGU4WDZIYnhpZ3RML05RNmtlT3o0ZkVJMWcx?=
 =?utf-8?B?VlR5ZXNjODhqV3gzVFBlYjdpQ1U3M2lsaDFnQkFqbit3cU9KSlU4Zng5VExn?=
 =?utf-8?Q?MY3aIt7mhxCCbd452JgReDs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CA7FF02BC3195046BD22DF3E57250E57@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2c2b9d3-1053-4da9-f65f-08dab10a0f0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2022 13:09:58.4950
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TcyS+/jvOc52FmFpAI1JZTZdgp+/GisMJI8dt1+6dHaJvYBiMNMogE/VDIeU4dga8T9XlJbisWYUqudqqqMSZTR62C9mZ5xJNlTK+28jDo8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB5635
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
