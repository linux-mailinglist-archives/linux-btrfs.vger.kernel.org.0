Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 283FA6A849E
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Mar 2023 15:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjCBOtd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Mar 2023 09:49:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbjCBOsX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Mar 2023 09:48:23 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C218A6F
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Mar 2023 06:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677768489; x=1709304489;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Gyhk7mJTBg9v20GsCis8zrCDCKlP+64nvIfmwABAXm4=;
  b=VIf/NaT+pSk+Qrp02asmFtbU6eq4uKaLAnHTXxrHoHpv/q97NxOtEM6g
   fxfGqyT/O+vs9PbTFysCnfT7pL3CNekGLj06E8vzTtK6bhj7IEv+4RhZY
   qaumZDoI8Kc4gPaRxgjCiFmCgMUeGyTbq0RTmJnezC9KCiXibSGL51Mbq
   k5eG3lTmE5SQdZ5ofq+jv0xevY2uSYIKBGlaQCMp6zmGQpekkv3W5/T8k
   +ciDDQSIEbmZ2zBwBpLMgC2T+tgFdbXuhydNEUeT52gg3w9t0a3Pj+TCD
   7qQgTaEjmH72fQy6jLfYcxpZWjKMfuS5p+g/vg//ISVW1eQPrwSDei1Or
   A==;
X-IronPort-AV: E=Sophos;i="5.98,227,1673884800"; 
   d="scan'208";a="224636013"
Received: from mail-dm6nam11lp2176.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.176])
  by ob1.hgst.iphmx.com with ESMTP; 02 Mar 2023 22:48:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H8UXmlWWq/OAtgjXn+v/Nw7FnfDyYlWHFNJdzST7NraaGtJ55PE9HlH3BgUfXJIaqtQTard/mAfWZVHamxA+LbJ46j3e9HpO09gf4MleJCitp1D1mBJXUupsdlqQwEVxxO2lF7Okgz0PBqOXe6U0+TGS7bqP1Yd+ocvs5tsVRHdNbCo+i6mYA5i74S5m1l1hqg1Q9UNkLZXUqPB1oPWJhlWSnQCjtit2Au8JGCqRbyveolYsaglw7xXGHXoTX1ds0o6ZopaeBqQJRLoEIXVZMfZf9YdHwLf5+F913qG+0o4pEEpY1DvvXinH9Muap5v77ClJCCUmr/WmgQ8lNNaL3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DRyWsEuBMJ0HmqOwlxQpbYJYWsjK1RD+OajfoaQWwjM=;
 b=kWhcHWMiSYEZ8V/wU5MCxF8Z0E/Ip+1WJBIQWLG0VXWXKO8nX1RhTTH7s9l/HL8NBb65iOCUuaLRlZRHCQoefy0s5XBpJNj+A/OEbklFJlC2joEEkQOCz0VX6wGPNVb6o9O/FGODzEDRINIg/aGeWA14kkJwstW0mkH/s2NvS8UqaGML621OQnR26e2e4WNYctLWCfNnsgMm4rhLe95iTgPSa+Sc+QRIS4NN8i4RxeLu/sRLI8dJqk0fb96D0ASV2TNhdr+SgdlSt1viTyDKjuEF0uQLgrJsE4ddcLpnjrTzjE3Y+z+Xk5m2wsVIjMASPHG0zs9eZjKBOWw4qVfSVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DRyWsEuBMJ0HmqOwlxQpbYJYWsjK1RD+OajfoaQWwjM=;
 b=qHrsaOYGmPl8NqWhFqFClNUTTtpWgiK7rjqw4D9WRG842sTuTa86JdRJhkLsfdzZrkLFUf0xmEMPEF9jPoqiRGlF2YaqLSdtbEmv4phFz3JpH7wzVDiDSvjy3S8m/2Rx9jpksxVfpZVQUgblyKDf3XvciiRS+8oWgHoCGKTHRH4=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by BN8PR04MB6049.namprd04.prod.outlook.com (2603:10b6:408:53::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Thu, 2 Mar
 2023 14:48:00 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::2e44:805:e7e7:8544]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::2e44:805:e7e7:8544%5]) with mapi id 15.20.6134.030; Thu, 2 Mar 2023
 14:48:00 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 2/3] btrfs: clean up space_info usage in
 btrfs_update_block_group
Thread-Topic: [PATCH 2/3] btrfs: clean up space_info usage in
 btrfs_update_block_group
Thread-Index: AQHZTRX7lrwhMz3ODU+DErNNrTjspw==
Date:   Thu, 2 Mar 2023 14:47:59 +0000
Message-ID: <20230302144759.akps5zdpmya4mm5b@naota-xeon>
References: <cover.1677705092.git.josef@toxicpanda.com>
 <f7a7a4beb5d9f249204fbca72a04b4cd78274c18.1677705092.git.josef@toxicpanda.com>
In-Reply-To: <f7a7a4beb5d9f249204fbca72a04b4cd78274c18.1677705092.git.josef@toxicpanda.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|BN8PR04MB6049:EE_
x-ms-office365-filtering-correlation-id: 0027abec-8123-4096-06a1-08db1b2d1e63
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DvWruv2yT24cyKc+i7vaLEqWQTzRLm3/pOaByDPlRyyBj5vdt1/7G19mfe/zx5Iy2X6UitFbi6iwBr+Mil5QB6Eb7ybfiGK0Krou5AKP07AGy1CVkzT3YOXSfwYmkKyTmhqso6rnXR5zyN/RCGINMX7HKxuNchWpgqbmeqxxxb5+g85OCN/aETALNOU0+p0o4unEKx76pYNY6wTll5a3mAKx5Ry3l2QkNGuiOsNhlA95zwft6UPOOaflXap3PQfxAICIYCredeH+4e6b+mvujQw0dLMxFbdhzCuhtP2f2u1wQQBTZAUqhNRDW0qUpbtYh4lfrGnhip+ZATUj9WSQkivTBVA4UFxXBfCcsXehzlRRaMM7ZUaD2/+JZhVz2K30ss5PL77AJF9uaXc29MqKcBICmTMKtjvLYpjElHjjPFFGbuH+q6OJ24y9iXhc15lJDJCYi/mrfXTH35yZtOtuDsDm+MJNoiSe3rnjTUBWngc1AyN47NDbcfp+G0IKXDc5CI0TU6bXGj9NlkHS6tafY3Potx6/IGonW8K8DItqMAs3MEBV8sUMfxqXUlzx/YpBByGiEq8+ahzSLvEb0MZ9ynDN1GiTA6rvST9tdm3Z0gk4CZcuJkZwgMxGniPS5tY493F1UyWGJxw6Zbx4YCnpU+UAlU9Hi8z0gEkaZI9+CJ7uKvVzry3h7jwycBiuvSE+jrcX3RE9tiJ9zHscNNJooA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(4636009)(39860400002)(366004)(376002)(136003)(396003)(346002)(451199018)(8936002)(4326008)(6916009)(5660300002)(4744005)(41300700001)(91956017)(66556008)(2906002)(64756008)(66476007)(76116006)(66446008)(8676002)(66946007)(54906003)(316002)(71200400001)(478600001)(6486002)(9686003)(1076003)(26005)(6506007)(186003)(6512007)(33716001)(122000001)(86362001)(82960400001)(83380400001)(38070700005)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iSG7NFUpwGM7b/C2aq2NJ8s9rFeADG/DEZzYYxzs+ukSr9N8G4vwu9E6qRm4?=
 =?us-ascii?Q?3pHt9WyaIx4IDZEJLGJZUpkLoi4lYOsp1Oam1XhtC1S5EeZ28JwFLrfwYlGK?=
 =?us-ascii?Q?Pera326lMaK3DH+Rx6IDEIwfDAN+QB4UGB2s9zEWtjpH1SULPwgq6zuGTilg?=
 =?us-ascii?Q?ugWLpVhVgADYclRo+Kt1aIvwynxO922zquoxyih6a7XSjsqM/PM5y3GW3tRe?=
 =?us-ascii?Q?hpCdCkkQvkKwHnFg4NN88nNzctARf8iDXKHMokyhP2r02Uh8j8kM/yJsb4hV?=
 =?us-ascii?Q?zutie+FT1UcgpWklWmCkOlYZCU9Ew9rNBFn4japRrwCYkhyciklaiEea89wS?=
 =?us-ascii?Q?pZdfP1ffvq93B7hEsV3Z8EvcoPvi3ZJbjPujNuYHW4MxXzBeO22y2IgxbeRB?=
 =?us-ascii?Q?Mc7eXSqv7wp1OioVgB54BGgU3ZB48C15v2LnV2ybkOEUxDnGhKPI3qXMmBzm?=
 =?us-ascii?Q?lMa2FV9FibU/+CxtNunDz6wMZ8jKIYo19hKiIJigl7yogAZ9/5zsq9pbSRR6?=
 =?us-ascii?Q?53C+ZQKglDjiLPkxEEDa+9sglTOiAvOl33I/v8zZ+oshJfJfUURulM1nxwLg?=
 =?us-ascii?Q?QuY7gKvRVSWjbwLOvgYrGOFXry+Yw5904xsz7m9QLHMYgjMkCrSy+TcPenA8?=
 =?us-ascii?Q?3MCXjZ88tVoVJNE8+Bf1RiTie4mOZWGHYbcLTGOPwlDIc5qUmJ9CKFrxod/N?=
 =?us-ascii?Q?O2foL/wevfs8rb9belHbpSyININlaGSMeT9R0wIXxy5DsL8svgdPlDKIYw36?=
 =?us-ascii?Q?Grt81tjnQ3XnM9otnUDQ1TIBsC4oP/0GIQ7VzPMyJwDsu27lEB8nK/jjHtSy?=
 =?us-ascii?Q?eTSwXwhapBqJiZjzmdpPme234ybCGu/DOwp47+1pQdYYPHeYBs/kdmT4fcYJ?=
 =?us-ascii?Q?hPNDg0E02yaxhLF3L6cer/GmqYrg3KkUwpSINADwcoyAzV0xM9RhwVt92y8h?=
 =?us-ascii?Q?KALoLKkketTY8LlBG1CNhV7ZuHqZ++W/YV9wd0TVtY5zTuDv6Q+1XUVM0X1C?=
 =?us-ascii?Q?HG8pYHL6iXYT4hJoWw7LWObAJre7Bmn0sRCFTUaUoqVWSLfLsRAvRM4rG5Sp?=
 =?us-ascii?Q?a8s7LAkSRccP79RDk9x+Pl35NKAONiBkJxDWyJOS9VFTLn7mLlzr2gX4MTtg?=
 =?us-ascii?Q?TjFZRtKLgFbnaiiyQsm+pkwhMjbOvZzsEiZCHkXCNvD7iNeye+TdNra0jVQ9?=
 =?us-ascii?Q?8N3tauZJeCPchtxwbuZlWBrdHmUEGDa8cWc0tNFZbJ4QB0jkJN4RQty9GEKo?=
 =?us-ascii?Q?QH2wTwpX2UbPZWyzfJOlz0wdpG6O06uiT5yuCTw9VJeeQB+wgD0SPYJ9LrFB?=
 =?us-ascii?Q?zBY/Db8d+1mVxLe+cbaZpaXMgdW7MIQtZp1UQNRWPy2j/10BGjrMGk0HiIKk?=
 =?us-ascii?Q?Mgf0uxDJwi/lLpN1bEBq0blBFRmGJ80ePiSIN8oN+QMWILfjpwb1aJz2plBE?=
 =?us-ascii?Q?R9a8KmZWNtjJr6hjhFrv/hUQIySBsjcW/lmZa3h9jLXj+QSI+NmXwBo5EHzT?=
 =?us-ascii?Q?CkBvksjv0wyHwN+UL2weeIM2v54dRGYP/C91abznf5qo87BYMEm1Xgq7hDZJ?=
 =?us-ascii?Q?hslYqquAIEahZnbG97e5u14Dkm2XgsnDBhUdgQabkMpE41fy8n+a9+uWIph9?=
 =?us-ascii?Q?nw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <570BAD824CB8764390D3EADFEDD163DA@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: RLES7ml6U45+vVe4rrzjANM/saA4egtyJm3qV+32A4EYscE++HEyrfXxQIKkhZOvlMmLOXtfLbehZXQ61YDYJq1h3dV5mWb2SOdg5IxWsWYMZzSWeJV/gfUUm5YonL+eLQG89gdwKPS71aHBXwSQPRBbsTXRzjVJdGf0viHr3/j0aM0ARb4GJSYawZVBa8N40ma57LDINMCrmARYakyrL42DKLUUEYl7hL041zR/ThM4VjmCJZTRL+1qQyfdngO5inY+PMAnP0638pDsx9IFve6pKRA5WwokaVpMI/zvBEnJGF2OQ1pB0dBGjWypYYIAES32O8yk6d61qpbJCJYS/DawlZfUgQSJmkCQHBwKmv/fG1VlNkBFLLo7BZ633sPPRSWawEmgHK4I6yWD1T3lWOigv4Q9q3/KZkPX2pCURNv4AenhmvSgRViwqim6WTnpmEZxGGwqY8FqfVDL9pPAOI2qtiNXMHqoXn9BWeqv77IG9ncIuwcyT84/pXULvSzwJuR/ywxcI02Aao45TOapT6VRoMhfVENaGS1y2DBvMJ4Xgw8Pi6hudPpjqhg9OaLlr/L376tgSEGq+BSO4hbpTLIvJGzblOA4IBDrI643H+vi8yq9gHcLUu+JNiujRKzIPH8HDBnVomMsmvVu517F1KuROLEZi5vQYOntWHXQoizRz9XVC3eWVAYdTLx/rYHu5JZdxIOmUM6ke/JvLvq+sMadb6a2btCXX2obWIev7uUMtNDTkB1WwORVYPppqW7ZGrCYIKZq+NHJF5lTry9nWO5KWwneDAbwn/ICSoRunnEK0Xx/RdGnHAC+rA21p0Z9VfJlYTisShSMxnVhn3MULg==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0027abec-8123-4096-06a1-08db1b2d1e63
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2023 14:47:59.9716
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w2mHtuIqgX/NUaOt3ZkoNPdWL28/f8mDYqx2F7WK3GeS+szGtJlAK7brqAoThTOZ/uGEsa0dgVHC68l0AZn0xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6049
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 01, 2023 at 04:14:43PM -0500, Josef Bacik wrote:
> We do
>=20
> cache->space_info->counter +=3D num_bytes;
>=20
> Everywhere in here.  This is makes the lines longer than they need to
> be, and will be especially noticeable when I add the active tracking in,
> so add a temp variable for the space_info so this is cleaner.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Looks good to me.
Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>=
