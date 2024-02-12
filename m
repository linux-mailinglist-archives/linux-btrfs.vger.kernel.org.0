Return-Path: <linux-btrfs+bounces-2318-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15ABC850FF3
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Feb 2024 10:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E925285813
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Feb 2024 09:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0B417BAC;
	Mon, 12 Feb 2024 09:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ftASb6jd";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="JslDwHzv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8EF79FD;
	Mon, 12 Feb 2024 09:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707731295; cv=fail; b=N9d8BB4MnB28/tSbIISKKYNGomXCqdE3efw8s5KETwvG8hhRwX1Z9HWh1f/Mi1HqitBr8bL0h83340Er1HKAIH66wGpjwbbs8plh9qyQRjg4b8uhzNjtYoWsux8LroAvXOL3Ow84L7znsEXRNVMR//ohIJ5cQuP0oAats+GxaYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707731295; c=relaxed/simple;
	bh=PCPSvlaW+zBSrfi61K59aVRFf2ES3ZmR6rQujaAZ2lI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rA+Y/6jSwD2m8juScdRJEqINybRx3jd1dSNCYEiSNdJpsSNro77EJ9xBjRf5wsr1MEuWEVOz11Fmr8SjwpLmcubNObgElxXaRLtJ+vXQy+W1VX/Coysd7Zd84HBk/8TWkPgaSe3Y/2QLemeDXXQtGKwJ6GKXDxfBx9X5ljmPIFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ftASb6jd; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=JslDwHzv; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1707731293; x=1739267293;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=PCPSvlaW+zBSrfi61K59aVRFf2ES3ZmR6rQujaAZ2lI=;
  b=ftASb6jdxMQUtiSCpuHJEsM7BpZX+EMWpwwXaTLgCKZ/23A06Q4z0Oj8
   6sfHVAUwEtOruA3A7kp5YJPAWll6WF8Thn0IJmjgyK6e4pESjLojACC5N
   oOrQwh4pZrdtCA4Q+OAjKFUm9LvKWZZyLUxC6kx1suev/mUvcDNfv/Y/7
   58p8r2j0c/02x1GVWqZyTYAp5HLepGjzai8lkMcOMaLN6pkaO0aZ+bO6o
   w7PWKAYSzPpkPa+8bPYBHWw1u9CZHvSYaD6i6nyRdnmdBL1tqczCa/sTX
   q2kHQtEgChB2OmpPpJZ9/kFUouHiLye4zHIxQSCyWJrbxbyGXQLhgp4lv
   A==;
X-CSE-ConnectionGUID: L1COMEvdQ7WL6pvXD3h17A==
X-CSE-MsgGUID: VC49+jf+RXOk2ypcgpfMkA==
X-IronPort-AV: E=Sophos;i="6.05,262,1701100800"; 
   d="scan'208";a="8952500"
Received: from mail-mw2nam10lp2101.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.101])
  by ob1.hgst.iphmx.com with ESMTP; 12 Feb 2024 17:48:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J8PIr+pmG44FVRERJp3NscJpRLOfmLiuHLXq5JPFThGfgBGDEtjggFKioeEMNprWYOW5puw0tfz+fXfQjparJ/86xWV9jPRVOPJ0g2tcTW2bHg7AuFCjabpzxOXKdvR2eK/D9ow4Sr64O0Bm5fAoFE4zsJzQtxJb/0Vl75rOfeMFAlCN9W8M7aqXJ10W9zIqxYi349ljhym2hgtWt9KWHOjmemNZRKJpBKRw9H+LZsD6KNYqPjSugvgvcZ3gV50j7+zoLZ/pA1VKY63wYZmK32q8KQ9m3GxRtwGILbAXSGxAqmJ3q/CctzZY/yF+8jPt7FaM6Mgle/mwcBfTi8rHLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PCPSvlaW+zBSrfi61K59aVRFf2ES3ZmR6rQujaAZ2lI=;
 b=M0NYKT6Ul1U2x/rePm2fXBZvJvq4WrPOPuRkxmW55nMQa/NsGTQMqhGxnsjwvFOldtW0u7VZzJC6PFEZMNNG5CRkKGolkkJEjjqgpiMKApv00zlKxAXaWdNab8CeIl7D90hAVIaRUHJORuSlWWubHRb22xeTdiQ+djCmVfmibM+ce+keoT35cHqtCo0fLeEnBj6WHxMV6x1fjPAV3KMJOzao2T7PgJJ7y5qQmTxuMje0PPcUwb+a1e5tdXq8gPDQXQt6rEKgNfAdk2jGsfip1zrFosmGmkOUNpfKS/z94WQWE0LwvsyRjwH0fDhpI4PsO90ti/yGM0n5nwYlskGjfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PCPSvlaW+zBSrfi61K59aVRFf2ES3ZmR6rQujaAZ2lI=;
 b=JslDwHzv7J/Beh8dh33rs1KiXG9dwb3Nyh5ZKS0g0NiWXAoNQ/zsam/q7cMfaAnAmDgbZWhJMbn9UO7pezeXthpVUGz0WO9duezvU4i+ZSeXH+crFugJThYQYjx12d+ps7emMY0TE/4Vd1Fdj/6jSZSxvuGluTgzYiD7fXBLI7A=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB6494.namprd04.prod.outlook.com (2603:10b6:5:1b5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.38; Mon, 12 Feb
 2024 09:48:09 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::649f:fe78:f90c:464c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::649f:fe78:f90c:464c%7]) with mapi id 15.20.7270.036; Mon, 12 Feb 2024
 09:48:09 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Filipe Manana <fdmanana@kernel.org>
CC: "fstests@vger.kernel.org" <fstests@vger.kernel.org>, Zorro Lang
	<zlang@redhat.com>, Anand Jain <anand.jain@oracle.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] fstests: btrfs: check conversion of zoned fileystems
Thread-Topic: [PATCH] fstests: btrfs: check conversion of zoned fileystems
Thread-Index: AQHaW05EIUnechE+00+NbAbiit0MjLEB6VUAgASROoA=
Date: Mon, 12 Feb 2024 09:48:09 +0000
Message-ID: <fbd427e1-2cc7-4106-a562-d3f9459a831f@wdc.com>
References: <20240209115057.1918103-1-johannes.thumshirn@wdc.com>
 <CAL3q7H6N-4vF-Sp+755_scxAZRvtT+Xkf_KCPoRuxBD6g9OYGQ@mail.gmail.com>
In-Reply-To:
 <CAL3q7H6N-4vF-Sp+755_scxAZRvtT+Xkf_KCPoRuxBD6g9OYGQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB6494:EE_
x-ms-office365-filtering-correlation-id: bb8145b9-baf6-4492-6098-08dc2bafb8c4
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 58ksx8Uc6kvpeLXfO+dnxu2SRikk0qpVYZ0zy7Ni4MdOALtZECO65STQ6gJnmW1w1Cx5qcKdS5RlK6Hb1kyV9qum6r6T9tDMgfkqaGeolhB/HE8d4jDGl0IOMhMnjjCJNsDaM2dytLB2CzvRTP8i9md/PNlfjSsmT1MJd67iE8mW/8mgCHQJ1ndH5UfEDdkV/T/kOQ2ouLYS6mTvCt8fBlzq+g2gNnDN5OdKNqKFNnb3Ye88L5YdT5he+WpC1rFsjkBeX7LrUjMx5d16iWuwdHVNchP93wNzpcfmlJo5W7eE+DW/r2AuSRqELUmXUVxj4gMhG1gIc2Cf/9UXdxIU3X5qA2mYKBytjleeQwha5OzLeT/zWvyIWSqQBAY+rsJa+KLk5NEYGArV5OJsp7otKUMbjEvy7XhkGnUAsINWK9SBFA1KpO6Vsdtl0XQzM5g3hFXqCyXGMAfyRXz9ECrN/ku8IK6r/rMRFpK1zcX9CS0ip8mj6iIpU4GpncVFHLzqoRp9G3xfmzLpTFYyKBbRSvUE41gtTHKr+dXWzuK++VTDyQ7eYbs6+ZDjQFrewmu0sPV6G0DfXtpjShOC/3PLB8sbKljnac+Bcveja4FF5jR1KxuCoHH8Jsp1lMJodGg5
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(39860400002)(396003)(376002)(230273577357003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(36756003)(38070700009)(41300700001)(2616005)(26005)(478600001)(8676002)(76116006)(83380400001)(66946007)(66556008)(66476007)(66446008)(8936002)(64756008)(6916009)(5660300002)(4326008)(54906003)(71200400001)(53546011)(6506007)(6512007)(316002)(31696002)(86362001)(6486002)(122000001)(82960400001)(38100700002)(4744005)(31686004)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VU9zaFJsSkJLUXZuOFB0VGVLenlJV1FWaGJ6aEk0SkVWb2w5d0ZWdGdjVjEw?=
 =?utf-8?B?TExtRW9LQjRBcTZHWXMwOWtIRXBNdUJyYWpZWFM3REVHajc0NnFZRDNCK0h5?=
 =?utf-8?B?RTRzbFRsZnJMSjBxNGIvKzFMUTY0bHFGQno4TUl2SC85VWVXczIvY2hPRDFT?=
 =?utf-8?B?eTZxUkErYldMcDdhT29tNHMzNEk5cXVIdFpzU2pncVNqL3d0RzUzN2duRmlB?=
 =?utf-8?B?THBQdkRHc1JKWk0vS2dCL3FjZVoyVnhMTzZGMWVYVjJaaFM4V0FoTjhaNmxn?=
 =?utf-8?B?ZjgyaHIvbHphYUtWNzVCalAxSjNKbDJ2aG9LaU1ubXNrTlZuVTVyWXByNHMy?=
 =?utf-8?B?aVpvT1BiVzFnK3pmaVo1b09lSDBlQ1RyaFljeVRCWklNbWNueHNRcUJjUzli?=
 =?utf-8?B?VHd4VTJDU2Y3YXY4NnlQeStpMG1kYnd6NlZxb2twcVlJbWQvQkVvbEtFNDBV?=
 =?utf-8?B?Nmk4eTJUdGNsQzdNRStNZUpYUmU0MzVwNS9rYUZsSkc0a1NHeGRPKytteXJi?=
 =?utf-8?B?Wm5jRkxmbGVJTEozazN0Q3d5aXRqUWx6SEZTU1p2K1lWQXNxaDdvSGpNUHBT?=
 =?utf-8?B?alRKWHY5MDQ4azBrNHRCU09IZUpuSEliRTFGZlBucUlJcURHTjdEZElEeEI1?=
 =?utf-8?B?N29SZGpZRHcwREorWXFGT20xUzB5Mkk3SzU1UGhWR29iVGV3cWNZYVRaZFFl?=
 =?utf-8?B?VXhPa2lBSEtlcGVJZWxpQnc4T3FnUkhxMFEzc3RDc3VDTE5PbUZjaWIzeDk0?=
 =?utf-8?B?MjNJNXlVRXVYendWNFVJNVFXQW8yRmNwRnlpcnc1NjRCSmJoOWllR01pZitp?=
 =?utf-8?B?MkZQVnBpcnp0MG94c1FJU2Q1YTk3QlRHWERYY3p3VDBzNGNrYXBoc2hpdm1v?=
 =?utf-8?B?cGpJVnRwWm0rVC9udlN0TzF2MGdFWGpMeXl5T1hWbklBZThGY3RSQXB3R2J0?=
 =?utf-8?B?TE1RSDNWbVEzRmtMYmUvNzRvdmNXdHBQTWMvampBR0ZyNVRSaXNYMEZLL3Na?=
 =?utf-8?B?Z3NFMjloK01lRmhYTUIrZEd2UHlMRGp1V3ZBSTA5WVl3UzlUbmY1eGUvejVX?=
 =?utf-8?B?aytqRXdPMU05c29ZSTBwVjRxbGhXTE5GNENvcVJZakF1cnNxZXhHek9VNGc4?=
 =?utf-8?B?aUwwdE0zSG9DcFh6REpENnd2WDJyeDdUYkJmQnRaVzMyUEZHdE43QzY5VGkz?=
 =?utf-8?B?MU5xTEViSHp2NnpxVGpXNUUxWWRPMVpvZGVIS1dKUUgyZ0QyVldlVHMyNXRO?=
 =?utf-8?B?cmJvOXV5VTZUakFtaGVadEVqcGdMQy9BdzJySU95VFdMdGVKYmlBRWRPeTRB?=
 =?utf-8?B?dERYMmpiNWJta2VrdUhoTVpxcHZiZFpUc054Q0tpaUhKU1pMVmlUVXROd2VJ?=
 =?utf-8?B?c0laWnVUeE9naXVnaDV0bWZ6a240OWVTQjlRdmljYUxCMHgxalJGR2t2czQ5?=
 =?utf-8?B?U2xydU5qVHdSbTdhcnhGUWJTOUZYenRQUDE1NnB5MmhJTyszQ0RsYmgwY0l1?=
 =?utf-8?B?eE9idlc1bVIxd3dLTUlnT3BLcW9uRXF0NUJpcGxGMjEwa2hpdXdqUUdYeHRj?=
 =?utf-8?B?RmZvQm1EOHl5WkdvU1lsYmVBWStpYVpzOVBaaUVzSGF2ODFnSUczbmx3UUti?=
 =?utf-8?B?RXd0Nlozdjg2eUpjTE1hV3hQZ2VVZ1NqbUtSSndhVXhnRTBPNlJSVjlpUHN2?=
 =?utf-8?B?TnFCM3lCRnVCeC9sSnpHNjl0eVZlSmxkdGx0NGI0R2tVV0ZhTGpaNHlPN293?=
 =?utf-8?B?OUJVTnRqeXJzWWYvYXpYQ2RpMmNvZ0tDL3pqNk9NK3Y5WTd1QzRLdUhUdzUx?=
 =?utf-8?B?RkpyRHB3cnBldVB5c1pBRkxvUVNvVXJoQlY2eUJ5dGY2WEpaWGg0K3VYUElO?=
 =?utf-8?B?enVkSnV3dlBKdldCY0pRNEV0NmZ5VDVnR0pWbkU2ek8rZDR4QmU3amYrMTdO?=
 =?utf-8?B?eitWbStERnh1T2p3Q3EwVUVLY08yNUJPTlRNQU1YM01GMnRpWTJIYjdHQ01x?=
 =?utf-8?B?a0FBRmZ6N3BqdnoxZlkvTGVUdW9oTGdyNW1LVU9SNU11M1dsZjlSZ2JXU085?=
 =?utf-8?B?S0Q5MEFZMndnQzlnWUhVSHFzN0NiUWcyTDZjcHZsSGI0ZUhsU0JKakUvcDda?=
 =?utf-8?B?TUQ2Yit2MzJhK2VkdHlNZ0hjNElCVlBkZXRQMXozbVFKUm1BN1cvRitGdW9v?=
 =?utf-8?B?SEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C15F39E15CF2BA4EA4A3D4F4ADA38357@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RdNWpl5dav3jnAyfK8y6sDQ81avNMr1a5w05sluIE0BDbasFQUiLfiLKzFY/xch3FUknF71PRI1kZXEYhmltOEreauPLY6rZ2xzWFI+MelfezEE2Q7w/FVPjdcZXYgM/0wxIQ1lNUGHm67mk9ZUREh2cnAh3lfDC/2Wm6/Vl5DgXwFIuf7yRfvb1bc8DKFLJBSuXtb50TIxCeurT/6nMfHupai0B+WECqNYKikuu1ilN2T3+I2S08VM3SVKO56GdNT1x0zHy/QtzZstN8WkPJG4K51xuwwa1tPZhsADshpzJFbD4HaiDGDz4N6/TSHXw7AVl5LCVfIUHdrRV3rrvwFCyKfAhEsk0giXIHQwyCEtb8OS5/Tg62gL0bsJGdbJ3EkWpeoVwgaT6DPJ4g2FX3JCxItD4t3T4/gVAQ3NipS587+kQUIQK5g63C2ZHOE4A1W1OFZZsll0ofpi0PB2nAy0HJfQyisdPu8aOvWUc4jIv1qYL939c3uss1Roe70pGSHrPZUWFsD1QlUtDc/yqwro60Dbfp/nyU3QmDTD1yV1UXGcODkA3BZ+13eLKF+KVa7S3YcLhxbSCQMEErL/gZ8awPU2n0txE4nhaSF5RY0rh2WahVVNDD1BJtfDHQkHG
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb8145b9-baf6-4492-6098-08dc2bafb8c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2024 09:48:09.8897
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9EzTypOcKJBRunWfCqWXyw8FBKsUnrXg2PScYlB8PXDhrnTUXofxf1XTJKjUJidSzxhr77AHCHIpVxDFHDe2PgMpaPuqQliN6S8p0rjTOHU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6494

T24gMDkuMDIuMjQgMTM6MDQsIEZpbGlwZSBNYW5hbmEgd3JvdGU6DQoNCj4+ICtFUlJPUjogZXJy
b3IgZHVyaW5nIGJhbGFuY2luZyAnU0NSQVRDSF9NTlQnOiBJbnZhbGlkIGFyZ3VtZW50DQo+PiAr
VGhlcmUgbWF5IGJlIG1vcmUgaW5mbyBpbiBzeXNsb2cgLSB0cnkgZG1lc2cgfCB0YWlsDQo+PiAr
V0FSTklORzoNCj4+ICsNCj4+ICsgICAgICAgUkFJRDUvNiBzdXBwb3J0IGhhcyBrbm93biBwcm9i
bGVtcyBhbmQgaXMgc3Ryb25nbHkgZGlzY291cmFnZWQNCj4+ICsgICAgICAgdG8gYmUgdXNlZCBi
ZXNpZGVzIHRlc3Rpbmcgb3IgZXZhbHVhdGlvbi4gSXQgaXMgcmVjb21tZW5kZWQgdGhhdA0KPj4g
KyAgICAgICB5b3UgdXNlIG9uZSBvZiB0aGUgb3RoZXIgUkFJRCBwcm9maWxlcy4NCj4+ICsgICAg
ICAgU2FmZXR5IHRpbWVvdXQgc2tpcHBlZCBkdWUgdG8gLS1mb3JjZQ0KPiANCj4gQnR3LCBpbnN0
ZWFkIG9mIHJlbHlpbmcgb24gYWxsIHRoZXNlIGxpbmVzIHN0YXlpbmcgdGhlIHNhbWUgYWNyb3Nz
DQo+IGJ0cmZzLXByb2dzIHJlbGVhc2VzLA0KPiB3ZSBjb3VsZCByZWx5IG9ubHkgb24gdGhlIGZp
cnN0IGxpbmUgb25seSwgdGhlIG9uZSB3aXRoIHRoZSBlcnJvcg0KPiBtZXNzYWdlIG9yIHN1Y2Nl
c3MgaW5kaWNhdGlvbiwgYnkgcGlwaW5nIGludG8gYSAifCBoZWFkIC0xIi4NCj4gDQo+IEJ1dCBh
bnl3YXksIG1pbm9yIHRoaW5ncy4NCj4gDQo+IFJldmlld2VkLWJ5OiBGaWxpcGUgTWFuYW5hIDxm
ZG1hbmFuYUBzdXNlLmNvbT4NCg0KR29vZCBpZGVhLCB3aWxsIHVwZGF0ZS4NCg0K

