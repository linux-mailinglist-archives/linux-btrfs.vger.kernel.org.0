Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB5A46F42CF
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 May 2023 13:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233984AbjEBL3a (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 May 2023 07:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233644AbjEBL31 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 May 2023 07:29:27 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8722D5B96
        for <linux-btrfs@vger.kernel.org>; Tue,  2 May 2023 04:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1683026932; x=1714562932;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=QEiT3rgrzYAsK194ooM32wtpQN5duBCvF1qle5Yy4RM=;
  b=N/5t5AAx4+YeqGrzsJ+QAjDlJE7A1d2Ub56zEv4nzpVo+9cJXYssvbwi
   TO4tgXilJxTw283XBE71b+ygl3kNwj8plQspIIzr+Z4eWZvAC6uO2hY58
   lHk4Ewxjy9p6wqAkb1q4jPhFtBfMsWLDLE1chC6aP9HlP1SmJZxXXTiqr
   Y3/AGsPgW2lHazqnc3wNlZR8qeNA6kmtg8kNUYmBLOAjE5BdXizNmsdeL
   EA5vrB0RR3EGXkJy7SlPJ8kjJNwSVDMENS68l3EdM88vOBykMjHVGLYI1
   EsuDgz2dESdc2leK99y5t7+ZnygsPlZGeSWCzdCTX8qhRznb3jWtap4y0
   Q==;
X-IronPort-AV: E=Sophos;i="5.99,244,1677513600"; 
   d="scan'208";a="341751788"
Received: from mail-mw2nam12lp2049.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.49])
  by ob1.hgst.iphmx.com with ESMTP; 02 May 2023 19:27:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TdWIdxBKhPtf3xdfrCQWdSti8+ubZO17xS4wB5XRJaBkUlP3RquQC3CazCWw7+KRLys5hdhNf+aOpLxwQIs3RK9OygHTTlzJtQvfRFQ91cvb5tYbpnlQcf0rMgaIUuUxrNtecUegxvpir5Jaup6CXVhqMsz839I2nRs2RNVnJnYBmj5e3jqxkWbZ+Pv54g5/Zj/a66ARACQ7SikIIa5q6HWcejvdiLUzHU8QKcbJgJyw3//NkszM7B7jcWsIdhIfDWV2E1d3xZHUdMPmq2/UnzeGkYDbD1KzSvC9luLXHbxJVbKbx2tVOZu29Lx0VE1baCV9YuU+RXpjai7Enp8I1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QEiT3rgrzYAsK194ooM32wtpQN5duBCvF1qle5Yy4RM=;
 b=MlOK9mh2hMACGnmCVRhWrvCdUD9EtTYsZCKY8Q9F3N6VI3AE/Wib1+d4FO3lSagxKxb4FT05YXPzkkDE8DOKJEGQcs4hInW130qqtg2e5QnKmYvapJXM/FzMtYI54RyP0NicyZFrv1dZ6cZutunZqsyrVbY8isFJJueFeAJF7flWrFvbUudU3cpNEApVDMiLWQdl1NWeYwxXd0E9tWcPsdEVfZjzZlhtk8AmbC3NGm1STTjOqupcyzdNhq2075atReBnv/lg+rg/ijGNqkRuPXhUFkzVIqIL8hvJjcFAxEnnZmnT/QbWw8KGXCJZaUbgX5fXKTt5GZ9qp1beElIIDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QEiT3rgrzYAsK194ooM32wtpQN5duBCvF1qle5Yy4RM=;
 b=rWR9nOxGnSNSMN6QZe7QVyKRTwjTIr+PFL/XnJB+L8SS8+fFd1E6I1Su1knwd4t4i+6vL/hxX8MF0bbhgLhWeoxRlN1id9w1Fd81iLHdua5u2MZqT9M6HF+RF+6CnSxmWXfzaJEW+hNoCnFzw+qxpi8LhfIrAh9MfNeR4oa5o4E=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ0PR04MB7198.namprd04.prod.outlook.com (2603:10b6:a03:297::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Tue, 2 May
 2023 11:27:36 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f%9]) with mapi id 15.20.6340.031; Tue, 2 May 2023
 11:27:36 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 03/12] btrfs: simplify btrfs_check_leaf_* helpers into a
 single helper
Thread-Topic: [PATCH 03/12] btrfs: simplify btrfs_check_leaf_* helpers into a
 single helper
Thread-Index: AQHZetZI8oUAnI6590uW1R0MALjlNa9G3IKA
Date:   Tue, 2 May 2023 11:27:35 +0000
Message-ID: <8949f55b-df8a-8236-e414-8ba9f37de6e5@wdc.com>
References: <cover.1682798736.git.josef@toxicpanda.com>
 <3f41d6e2a62eacc4a31966dfaa8a3e0b8f64766b.1682798736.git.josef@toxicpanda.com>
In-Reply-To: <3f41d6e2a62eacc4a31966dfaa8a3e0b8f64766b.1682798736.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SJ0PR04MB7198:EE_
x-ms-office365-filtering-correlation-id: bfeafc21-17c9-4e9d-f74f-08db4b003ab2
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5BB2TZrqpSRYMqFIhHQMxEbVjRjEtrahy2VIlxt4FtjFjCFJLQsv+RsKm7dMv8JFherbeHZ+9YXqHao+eBnsaMnjKo1ZGYdDy9OKlZz64XJBaSEi1cKHoaDW3BaO7TZgOuA33catdaj0ZhDyAEzpQ3f8yWWo1KPLIhh8WUQJGP47oL60TeeIiCbIpL8XDCrWf30rVeEG9nYunl2fG0j+SRfG7mP67cv9phylBWA6oM7EkKdrXb02SeSwx+6Vq+UIpn2gZvNDI6F1YTmqgUJMCfE012ZceOIOXCCNyQ2GuUMSpIMpcbsXetRvox0O98B2D78mD7A1HD2Mo2BlVguPajoBB/06HaOnqZihmSIC6KOSk3/svmKGMPbqPJbVriNUyHAHos9EdRbd8ieZyW7hLvKU+1bG7mGHMn9BBRaMfT6sBhGLoJMoQVYb0nqbXvsa/3Gx8KhsyuMdObhkyZyOMEp9p0IA87eTf7xlV+NcsMjtFrPu0VASPBpzMSVs5gArI3ZO4bAEZuFM6KbzoBEEVt1wHjO7FbEGwRL81/baZcQpuifP5cY7aCf+kZIsNvRRU2kZemZBiQDwlJOjJRKHMtACvIKHWQ4WGUZUZA3GZYIYvChHhwVPNlCRXMteDX7ol4YOHZGI4/l/OpUraC6VmmG/2ZOR6nXDMuTe1kjnFER592+CCLmEeECYKxyOomxf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(346002)(376002)(136003)(396003)(451199021)(31686004)(41300700001)(82960400001)(122000001)(2906002)(86362001)(36756003)(316002)(8936002)(5660300002)(66446008)(66556008)(64756008)(66476007)(31696002)(66946007)(76116006)(8676002)(110136005)(38070700005)(478600001)(53546011)(6512007)(6506007)(91956017)(71200400001)(2616005)(186003)(6486002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YWZuSmpwK2xWMjRuWUZ6cEVScjd2Y1NKOWVyL21NQmo2ZVN4OWpSM1NUaldZ?=
 =?utf-8?B?NTJPSzVnWkhBL0srR05tMWdhSENVOCsrTSt4Tmg0VENndnBJL1A1ZVNQWGJr?=
 =?utf-8?B?S2RyK2JmVVNtZVFSTG1kUDV2WDYxL3prcnNQTS9IWm1xc1EyWXAzRlFuMklL?=
 =?utf-8?B?ZGNYSjV6Y0Jock9aTnJlTUwwS0hkeFNSSVBkVG4zckRTSjBrYnNFT0txc3NZ?=
 =?utf-8?B?THBCQmZzNGc4OUF5ZDFtbnMxaEJQSDZEM1JmdDNEQzM0cTdmbE01VFVUZndF?=
 =?utf-8?B?a1o4bng5Q3Jkb1I0bmVHVHFuOTFtME8vTDlyZXExUGZIc1Myd1Fta1JMb0R1?=
 =?utf-8?B?Rk10dzV2ZjBLdzhPaWc2RURkWXEzTk0rT25BWU10Vi9tb0NLTng3cTM1YzFS?=
 =?utf-8?B?MXhEblhDbFZLcUVkOE1Ma0RBZzV4MGd4S1VTdmJyVE5tcDZDZjZEbHNoRkU3?=
 =?utf-8?B?ZlplSmczTkJOVmcwTVZLV0VZZ0ZGWVptSnVoTjFPaWVCM05vdVpkYUJUSkk2?=
 =?utf-8?B?WkZteVhBUmNvbnJHR1ZUU0NxN3o3d1FiRlRpV3UzWDZEUE9QWEE3Smt0ZGp6?=
 =?utf-8?B?Mzk0VTR6dnhKcklhY3l6cGZnczMyelRXSWFQdG83OHY3NFl0MFhiajVPa3dz?=
 =?utf-8?B?MXNNalNnSWNWU2lvNDRLZmJ6R2RwMkRpNTBPTzdKYmxST1lqZUJPUHVlRWNm?=
 =?utf-8?B?TFVKc2QwR1RCaEJjOHNKQXhSYXhzWFJkZ2JaWnprZklrblRWdXRxaldlelFk?=
 =?utf-8?B?M2lNWWFmd2tOelhtUnJSVkV1bUp3QzM0dnhRREZNK0s3QWc5OUM3U3ZmQTlG?=
 =?utf-8?B?cmswMGdzcENsTVkvL2dMY25XbGpnZHFRM09sRm9PeWJrUERDZjNJNEJ4NnE5?=
 =?utf-8?B?REN5ZTgrempOcVFyMHpYN2JubHlXZVUwMWNPb0tvNEpHd3BpNU5HbzVNaGdi?=
 =?utf-8?B?R0xwdmgvaXp5T3BKbVU3YXU4dzNlK2VrNHRIY3crb1lnL0pTeUdRQ3VRL0hJ?=
 =?utf-8?B?OU1zNjJoTGtQek0rd2pTeUtsUE1pdDg0TnVEK0VhbWdZNTdQWllpNDlRcFF1?=
 =?utf-8?B?MFhFaTNjbU5aeEpuWEVGckRHVGFGbnlEM3FuaEF3NmM2RlBGK3RPU1g0c2pM?=
 =?utf-8?B?eVNNZ29SRnZtcEZvK01OVENscFZUQ0huakJNM3ZZUTVUd2VlK3U0ejNndW1C?=
 =?utf-8?B?U1FSS2VXektKY0QyTDhMOUpXblFqYWN3M0ZnTENrUm5neWRqYjI2bmxBaW04?=
 =?utf-8?B?a0JDWDRsaGdHOXMxc1FFaTRQNXJhK05ZSXFzb1RzT0JOZXhMRW1Pa0lPV3Vn?=
 =?utf-8?B?K0QvYzRiZEppS3BRWUNHRGI4QjZsSXJyUTJpT0lqb3g5Zk5YQThLVWFtUGQ4?=
 =?utf-8?B?OEVuUWtxRFVLU1NnVnpkdEM4WWc0YUZTVUx1cG9lVmxUNmpiOXF5b3lZYnpL?=
 =?utf-8?B?MTRhOUdFRkovblc4UDB2aWg4REdXWHBIREQxNy82cnlKYjJrOFA5MmsrM3Zz?=
 =?utf-8?B?U2UrNllNZ2tTUzA1dHVLNEVPbzBydkE3Qk5VQjBraGxxek0zaFptMWl3U3cy?=
 =?utf-8?B?ZDB0ZUgxUWprUCtlWWVKTVFyUkxrYTJSQUY1UnRFemxDM2FJQmxrN2JnZit0?=
 =?utf-8?B?clFyRlBxc0dKQXUwOEFLaVJjU3QvWXVZRSs3NjZoNHFKL3VRa09DYk1CcGFw?=
 =?utf-8?B?SjVQQVRybGNWY25nNWZEY1NucEVKbkJ3TE1HWGNwbG9sS2o4UTdkeWplTDRn?=
 =?utf-8?B?cnV5cG1OMkNOUnoycUhzL3lsSmlSSkpnREd4RTZiNHh2QUlDbXBEb05UL3I5?=
 =?utf-8?B?Vkg2c1JxZnYxSmgrVnZLUFhFZmhUdUpZVVNmbEdDWS8wQWozL3ovbWtwNjBZ?=
 =?utf-8?B?eHVpVDBIejJVZzJkVWhucHM3d0k3RXIxM0REN3U1d0hOL3lKY0x6c085TXJ6?=
 =?utf-8?B?TERPeXhqSGNhK3R2dVAxZXRVcmRnUTJoTkFWeUhoNzFSN3I5Vi9TbkNvdldE?=
 =?utf-8?B?Y2Y0aVZSdjl0L1FZWnVLbnFTb28xWWVlSGNXeTk1MHhEWUhBbUlNTk1hdnYy?=
 =?utf-8?B?bExlZ0RMK3pkTnBXc1A0d2JQaHo1dWVJRElIQ1NGbldQbTZjYlJ1dk14ZXhZ?=
 =?utf-8?B?L3ZkV0s3NE5aS3FkZHVpV3FMTjF6emRhWW1jYk1zK3djOEtjVVBLUWVqK1Bz?=
 =?utf-8?B?Vjl4bmxhUWJ6YmpYUGgvaXRubDJpQm5YYlBWVUZXRFp2WTRQZWppemxNVHhK?=
 =?utf-8?B?aHFjUjF2SGYrR3RLZDZ3TmZvUWZBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7BDA1DA62055D0439DB6B2E728ED68F4@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: zTwqat98n+++DRjWERwWD098wHMRqeUv7VKJ/yCwQQLEnXOki4+sGt92918QvbDAPOX9Dw0TlaW0B0CKpgK2TwlHsLSVSL1mYEBz9RLXXtjiIXYm5o0tqiwZ5Zd753K400qmf3Oi29GveLoRdt1vW3rospKDc/GVCaFlyWBBw/Jt5nUBEOjfga/Qx4YPT01rEN52B8eax2E9fkEn85Z8UdTS60Cd5qtBehvzMiOkwkJOfDrmxDeT92UdPXkMOvKswuGaipetQ1/X2fZV8qOj1fh0+ju6inYlqFMWdz/NWdJ95NxPVCuoMRTuf2iVgTkaTJ/0tLPgaf6XrWGE0a0wD0NOo8g0Ut+isQbnpoC1ZRR4Jr1KLfoAv483xkLnESvZLyKWvnvoYGbL1yF7sIZivhlx+0rB8tOSQmxunVyTVW9sFvkKhwb2J6ei2KpUxdK7gD/5WQD8To9nFAysiptptQTiGgPZv94Y2AYSOmWOtQl/T5T1c2uxb65MgTaH54WSjAeb0i4Juv+sEK3DY3nPqVijuEGRayUlGoYN39EO59PAtRFphjlv5KqkJtD2X0XQquV9FWliR+8ML9burb3l3hO0CNXhDdbA0oLudm+gQAT5RmF9i5MnkNBdsTYcIrCTAPxpN0b2T2aJXysCml+fLltIrV9Mr87CCwJ//8pxADf7LXXCqF7/rcy7zBysL2uVB6KMP25MLfO0xV7nCCov94j5CaWlJcSz+lLw14f+4w63/GV2wKn7dagkbLsU8tqLUqpXlBHaqCE/3U445z3e4SiTdU67JZjPADhHCVmzYLQBDGrlzUJXdi0z1KD2u7gdxw8tLG5U+mxSW0fuqBcsXA==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfeafc21-17c9-4e9d-f74f-08db4b003ab2
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2023 11:27:35.9801
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0odnWO+xDUs+sdMvAR7xOcQdkgTLsfXSgDXaE4wxG+fMD65mqQTaXLGTze6G7RIuRAc7Jz1r9O9KdaUDD4U7V/TWLcfHBsf543dzmAlA0vg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7198
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMjkuMDQuMjMgMjI6MDcsIEpvc2VmIEJhY2lrIHdyb3RlOg0KPiAtc3RhdGljIGludCBjaGVj
a19sZWFmKHN0cnVjdCBleHRlbnRfYnVmZmVyICpsZWFmLCBib29sIGNoZWNrX2l0ZW1fZGF0YSkN
Cj4gK2ludCBidHJmc19jaGVja19sZWFmKHN0cnVjdCBleHRlbnRfYnVmZmVyICpsZWFmKQ0KPiAg
ew0KPiAgCXN0cnVjdCBidHJmc19mc19pbmZvICpmc19pbmZvID0gbGVhZi0+ZnNfaW5mbzsNCj4g
IAkvKiBObyB2YWxpZCBrZXkgdHlwZSBpcyAwLCBzbyBhbGwga2V5IHNob3VsZCBiZSBsYXJnZXIg
dGhhbiB0aGlzIGtleSAqLw0KPiBAQCAtMTY4Miw2ICsxNjgyLDcgQEAgc3RhdGljIGludCBjaGVj
a19sZWFmKHN0cnVjdCBleHRlbnRfYnVmZmVyICpsZWFmLCBib29sIGNoZWNrX2l0ZW1fZGF0YSkN
Cj4gIAlzdHJ1Y3QgYnRyZnNfa2V5IGtleTsNCj4gIAl1MzIgbnJpdGVtcyA9IGJ0cmZzX2hlYWRl
cl9ucml0ZW1zKGxlYWYpOw0KPiAgCWludCBzbG90Ow0KPiArCWJvb2wgY2hlY2tfaXRlbV9kYXRh
ID0gYnRyZnNfaGVhZGVyX2ZsYWcobGVhZiwgQlRSRlNfSEVBREVSX0ZMQUdfV1JJVFRFTik7DQo+
ICANCj4gIAlpZiAodW5saWtlbHkoYnRyZnNfaGVhZGVyX2xldmVsKGxlYWYpICE9IDApKSB7DQo+
ICAJCWdlbmVyaWNfZXJyKGxlYWYsIDAsDQo+IEBAIC0xODA3LDYgKzE4MDgsMTAgQEAgc3RhdGlj
IGludCBjaGVja19sZWFmKHN0cnVjdCBleHRlbnRfYnVmZmVyICpsZWFmLCBib29sIGNoZWNrX2l0
ZW1fZGF0YSkNCj4gIAkJCXJldHVybiAtRVVDTEVBTjsNCj4gIAkJfQ0KPiAgDQo+ICsJCS8qDQo+
ICsJCSAqIFdlIG9ubHkgd2FudCB0byBkbyB0aGlzIGlmIFdSSVRURU4gaXMgc2V0LCBvdGhlcndp
c2UgdGhlIGxlYWYNCj4gKwkJICogbWF5IGJlIGluIHNvbWUgaW50ZXJtZWRpYXRlIHN0YXRlIGFu
ZCB3b24ndCBhcHBlYXIgdmFsaWQuDQo+ICsJCSAqLw0KPiAgCQlpZiAoY2hlY2tfaXRlbV9kYXRh
KSB7DQoNCg0KTml0OiBJJ2QgZXZlbiBnbyBhcyBmYXIgYXM6DQoNCmRpZmYgLS1naXQgYS9mcy9i
dHJmcy90cmVlLWNoZWNrZXIuYyBiL2ZzL2J0cmZzL3RyZWUtY2hlY2tlci5jDQppbmRleCBmMTUz
ZGRjNjBiYTEuLjJlZmY0ZTJmMmM0NyAxMDA2NDQNCi0tLSBhL2ZzL2J0cmZzL3RyZWUtY2hlY2tl
ci5jDQorKysgYi9mcy9idHJmcy90cmVlLWNoZWNrZXIuYw0KQEAgLTE2ODIsNyArMTY4Miw2IEBA
IGludCBidHJmc19jaGVja19sZWFmKHN0cnVjdCBleHRlbnRfYnVmZmVyICpsZWFmKQ0KICAgICAg
ICBzdHJ1Y3QgYnRyZnNfa2V5IGtleTsNCiAgICAgICAgdTMyIG5yaXRlbXMgPSBidHJmc19oZWFk
ZXJfbnJpdGVtcyhsZWFmKTsNCiAgICAgICAgaW50IHNsb3Q7DQotICAgICAgIGJvb2wgY2hlY2tf
aXRlbV9kYXRhID0gYnRyZnNfaGVhZGVyX2ZsYWcobGVhZiwgQlRSRlNfSEVBREVSX0ZMQUdfV1JJ
VFRFTik7DQogDQogICAgICAgIGlmICh1bmxpa2VseShidHJmc19oZWFkZXJfbGV2ZWwobGVhZikg
IT0gMCkpIHsNCiAgICAgICAgICAgICAgICBnZW5lcmljX2VycihsZWFmLCAwLA0KQEAgLTE4MTIs
NyArMTgxMSw3IEBAIGludCBidHJmc19jaGVja19sZWFmKHN0cnVjdCBleHRlbnRfYnVmZmVyICps
ZWFmKQ0KICAgICAgICAgICAgICAgICAqIFdlIG9ubHkgd2FudCB0byBkbyB0aGlzIGlmIFdSSVRU
RU4gaXMgc2V0LCBvdGhlcndpc2UgdGhlIGxlYWYNCiAgICAgICAgICAgICAgICAgKiBtYXkgYmUg
aW4gc29tZSBpbnRlcm1lZGlhdGUgc3RhdGUgYW5kIHdvbid0IGFwcGVhciB2YWxpZC4NCiAgICAg
ICAgICAgICAgICAgKi8NCi0gICAgICAgICAgICAgICBpZiAoY2hlY2tfaXRlbV9kYXRhKSB7DQor
ICAgICAgICAgICAgICAgaWYgKGJ0cmZzX2hlYWRlcl9mbGFnKGxlYWYsIEJUUkZTX0hFQURFUl9G
TEFHX1dSSVRURU4pKSB7DQogICAgICAgICAgICAgICAgICAgICAgICAvKg0KICAgICAgICAgICAg
ICAgICAgICAgICAgICogQ2hlY2sgaWYgdGhlIGl0ZW0gc2l6ZSBhbmQgY29udGVudCBtZWV0IG90
aGVyDQogICAgICAgICAgICAgICAgICAgICAgICAgKiBjcml0ZXJpYQ0KDQpPdGhlcndpc2UsDQpS
ZXZpZXdlZC1ieTogSm9oYW5uZXMgVGh1bXNoaXJuIDxqb2hhbm5lcy50aHVtc2hpcm5Ad2RjLmNv
bT4NCg==
